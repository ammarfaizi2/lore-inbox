Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284615AbRLJU0Q>; Mon, 10 Dec 2001 15:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286376AbRLJU0G>; Mon, 10 Dec 2001 15:26:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64268 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286375AbRLJUZv>; Mon, 10 Dec 2001 15:25:51 -0500
Subject: Re: Linux/Pro  -- clusters
To: Andries.Brouwer@cwi.nl
Date: Mon, 10 Dec 2001 20:34:24 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <UTC200112101951.TAA270246.aeb@cwi.nl> from "Andries.Brouwer@cwi.nl" at Dec 10, 2001 07:51:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DX84-0003Lt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     And it means we can get proper refcounting. Which as the maintainer of
>     two block drivers that support dynamic volume create/destroy is remarkably
>     good news.
> 
> You say this as if that would be a difference between the two
> approaches. I don't think it is.

Its easier to make sure its correct when we have a single structure not
a pile of arrays. Object lifetime becomes explicit, and we don't have to
worry about re-use races since a new instance of that major,minor will have
a different object attached to the one in use that is about to be refcounted
into oblivion by currently active requests
