Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbSK1Swo>; Thu, 28 Nov 2002 13:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbSK1Swo>; Thu, 28 Nov 2002 13:52:44 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:52103 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S266718AbSK1Swn>; Thu, 28 Nov 2002 13:52:43 -0500
X-Envelope-From: kraxel@bytesex.org
From: Gerd Knorr <kraxel@bytesex.org>
Message-Id: <200211281823.gASINAuN014312@bytesex.org>
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RELEASE] module-init-tools 0.8
In-Reply-To: <200211281616.gASGGOE6012229@bytesex.org>
References: <20021128023017.91FAC2C250@lists.samba.org> <200211281616.gASGGOE6012229@bytesex.org>
Date: Thu, 28 Nov 2002 19:23:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  alias char-major-6 lp
>  alias parport_lowlevel parport_pc
>  
>  Smells like a deadlock due to request_module() in some modules init
>  function or something like this.

Next try:  Changed "alias char-major-6" to "off".  Works better, at
least the system comes up with all network stuff working and I can
login as user (with $HOME at nfs).  Various modules still fail to
load (bttv driver, matroxfb):

WARNING: Error inserting v4l2_common (/lib/modules/2.5.50/kernel/v4l2-common.o): Invalid module format
WARNING: Error inserting video_buf (/lib/modules/2.5.50/kernel/video-buf.o): Invalid module format
FATAL: Error inserting bttv (/lib/modules/2.5.50/kernel/bttv.o): Unknown symbol in module

WARNING: Error inserting matroxfb_misc (/lib/modules/2.5.50/kernel/matroxfb_misc.o): Invalid module format
WARNING: Error inserting matroxfb_accel (/lib/modules/2.5.50/kernel/matroxfb_accel.o): Invalid module format
WARNING: Error inserting matroxfb_DAC1064 (/lib/modules/2.5.50/kernel/matroxfb_DAC1064.o): Invalid module format
FATAL: Error inserting matroxfb_base (/lib/modules/2.5.50/kernel/matroxfb_base.o): Unknown symbol in module

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
