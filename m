Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbRHKNMG>; Sat, 11 Aug 2001 09:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267579AbRHKNLr>; Sat, 11 Aug 2001 09:11:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18951 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267542AbRHKNLo>; Sat, 11 Aug 2001 09:11:44 -0400
Subject: Re: VM nuisance
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 11 Aug 2001 14:13:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9l272e$7eo$1@cesium.transmeta.com> from "H. Peter Anvin" at Aug 10, 2001 07:59:26 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VYaU-0002aw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Followup to:  <Pine.LNX.4.33L.0108102347050.3530-100000@imladris.rielhome.conectiva>
> By author:    Rik van Riel <riel@conectiva.com.br>
> In newsgroup: linux.dev.kernel
> >
> > I haven't got the faintest idea how to come up with an OOM
> > killer which does the right thing for everybody.
> 
> Basically because there is no such thing?

And also because 

-	people mix OOM and thrashing handling up - when they are logically
	seperated questions.

-	The 2.4 VM goes completely gaga under high load. Its beautiful under
	light loads, there nobody can touch it, but when you actually really
	need it - splat. 


So people either need to get an OOM when they are not but in fact might
thrash, or the box thrashes so hard it makes insufficient progress to
actually get out of memory.

OOM is also very hard to get right without reservations tracking in kernel
for the journalling file systems and other similar stuff. To an extent
thrash handling also wants RSS limits.
