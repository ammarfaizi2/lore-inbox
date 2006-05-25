Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWEYGhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWEYGhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 02:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWEYGhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 02:37:31 -0400
Received: from smtp.enter.net ([216.193.128.24]:43012 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S965038AbWEYGha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 02:37:30 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: OpenGL-based framebuffer concepts
Date: Thu, 25 May 2006 02:37:19 +0000
User-Agent: KMail/1.8.1
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com> <4475007F.7020403@garzik.org>
In-Reply-To: <4475007F.7020403@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605250237.20644.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay... 

Seeing the explosion of posts relating to this and the ideological split I see 
here I'm now left with the undesirable job of choosing which of two contested 
paths to follow with writing the code.

The path I agree with - the "One Device - One Driver" path - seems to be 
disliked by a lot of kernel developers, and would likely see my code not 
being merged anytime in the future.

The other path - that asking for a mediation layer so multiple drivers can use 
the same device - seems to be in large favor, will likely see the code 
merged... But it requires doing something that I'm not sure is the right 
thing to do.

I've spent a good portion of the past two days pondering this and trying to 
figure out a good way to go about things, and it seems to me that the best 
idea would be to add a "third" graphics system. However, this third graphics 
system would be mostly transitional code aimed at supplanting the fbdev and 
DRM kernel code.

The goal of adding said "third system" would be to provide a minimal 
kernel-level API for interfacing with the hardware acceleration features and 
providing a userspace library for doing most of the interfacing work. 

Done properly (something I always try for) this system would supplant DRM on 
Linux by providing a built-in system for accelerating all grahpics 
applications. This system would be quite similar to ALSA in nature and 
spirit.

I'm asking for advice from the experienced people on this list for help, since 
until I have a clear picture of what the kernel needs in a "modern" graphics 
system I cannot proceed. 

DRH
