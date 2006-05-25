Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbWEYIon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWEYIon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 04:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWEYIon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 04:44:43 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60316 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965089AbWEYIom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 04:44:42 -0400
Message-ID: <44756E70.9020207@garzik.org>
Date: Thu, 25 May 2006 04:44:32 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "D. Hazelton" <dhazelton@enter.net>
CC: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com> <4475007F.7020403@garzik.org> <200605250237.20644.dhazelton@enter.net>
In-Reply-To: <200605250237.20644.dhazelton@enter.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Hazelton wrote:
> The goal of adding said "third system" would be to provide a minimal 
> kernel-level API for interfacing with the hardware acceleration features and 
> providing a userspace library for doing most of the interfacing work. 
> 
> Done properly (something I always try for) this system would supplant DRM on 
> Linux by providing a built-in system for accelerating all grahpics 
> applications. This system would be quite similar to ALSA in nature and 
> spirit.
> 
> I'm asking for advice from the experienced people on this list for help, since 
> until I have a clear picture of what the kernel needs in a "modern" graphics 
> system I cannot proceed. 

I really hate to be a killjoy to one who is so enthusiastic, but to be 
perfectly blunt,

* I doubt you will get much help.  From GGI to today, the world has been 
full of people who have a clear picture of where Linux graphics needs to 
be... and they never got very far.  So if you don't already have a clear 
picture, you have ever farther to go.

* You really need to already know a good deal about graphics hardware, 
old and new, before starting down this path.

* Review Dave Airlie's posts, he's been pretty spot-on in this thread. 
There needs to be a lowlevel driver that handles PCI functionality, and 
registers itself with the fbdev and DRM layers.  The fbdev/DRM 
registrations need to be aware of each other.  Once that is done, work 
will proceed more rapidly.

And mind you, _I_ am saying all this as one of the crowd who wants to 
rewrite Linux video... once I get a free year or two.  I got my start in 
kernel graphics (fbdev) ~ a decade ago, and I've followed the graphics 
world intensely even since.  However, the more realistic people will 
just re-read DaveA's posts.

The path you suggest -- a third graphics system -- is going to be 
completely ignored by everyone unless/until its so wonderful that we 
just _have_ to switch.  And given past history (GGI, ...) it will be a 
lonely path for a long time.

	Jeff

