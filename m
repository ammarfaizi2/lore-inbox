Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266577AbRGOOBz>; Sun, 15 Jul 2001 10:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266614AbRGOOBq>; Sun, 15 Jul 2001 10:01:46 -0400
Received: from c008-h009.c008.snv.cp.net ([209.228.34.72]:24032 "HELO
	c008.snv.cp.net") by vger.kernel.org with SMTP id <S266577AbRGOOB1>;
	Sun, 15 Jul 2001 10:01:27 -0400
X-Sent: 15 Jul 2001 14:01:24 GMT
Message-ID: <3B51A22F.16C6FEBB@acm.org>
Date: Mon, 16 Jul 2001 00:01:19 +1000
From: Gareth Hughes <gareth.hughes@acm.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-ac3
In-Reply-To: <E15Llhc-0003zS-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> DRM 4.1 is something that needs discussion rather than being ignored. I sort
> of expect it to look like XFree code anyway and I can see bits of the macro
> stuff will really help with the *BSD code

Some of the discussions I've had with various people regarding the DRM
make me think people miss how tightly coupled the 3 parts of a full DRI
driver are (the other two parts being the XFree86 2D driver and the
client-side 3D driver).  It's not like the various interfaces between
the 3 parts are changed for the fun of it.  Granted, issues of backwards
compatibility haven't been handled well in the past, but with the next
resync I believe that moving forward this will no longer be a problem. 
You'd have to talk to the guys at VA about this, however.

Portability and maintainability were certainly two motivating factors in
the move to a templated architecture for the core DRM.  I just got sick
of seeing the same code in every driver -- kinda defeats the purpose of
having a "core" DRM if it isn't being used...  New drivers are much
easier to write as well, which is a nice side-effect.

-- Gareth
