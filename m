Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266524AbTGEW22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 18:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266527AbTGEW22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 18:28:28 -0400
Received: from poup.poupinou.org ([195.101.94.96]:19485 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S266524AbTGEW20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 18:28:26 -0400
Date: Sun, 6 Jul 2003 00:42:51 +0200
To: Daniel Cavanagh <nofsk@vtown.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bsd disklabel and swap
Message-ID: <20030705224251.GA8991@poupinou.org>
References: <3F04FFD0.2060404@vtown.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F04FFD0.2060404@vtown.com.au>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 02:17:20PM +1000, Daniel Cavanagh wrote:
> hi
> 
> i'm having a problem with a bsd disklabel and swap.
> my /dev/hda disk look like this
> 
> partition 1: fat
> partition 2: ext2
> partition 3: openbsd
> 
> it is a standard bsd disklabel with a as root and b as swap. this means 
> that /dev/hda6 should be the swap partition. but "swapon /dev/hda6" 
> prints "swapon: /dev/hda6: Invalid argument". it also prints that for 
> any other valid partition. if i put this in /etc/fstab, on boot the 
> kernel will print "Unable to find swap-space signature" before swapon 
> prints the above message. but if i use /dev/hda3 instead, swapon will 
> accept it and add a 512Mb swap, which is the correct size. but it 
> appears that rather than writing at the start of the swap it starts 
> writing at the start of the openbsd partition so my root partition is 
> being corrupted. have i screwed or have you guys screwed up?
> 
> im running slackware 9 (2.4.20) with a recompiled kernel. my .config is 
> attached if you need it.
> 
> thanks, daniel
> 

By compiling with CONFIG_BSD_DISKLABEL, you actually have
changed the /dev/hdaXX numbering scheme so that /dev/hda6 may be
now one of your OpenBSD partition.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
