Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVDVXDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVDVXDb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 19:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVDVXDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 19:03:31 -0400
Received: from mail.dif.dk ([193.138.115.101]:45520 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261267AbVDVXD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 19:03:27 -0400
Date: Sat, 23 Apr 2005 01:06:36 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Randy Gardner <lkml@bushytails.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd?  Can burn DVDs, just not read them...
In-Reply-To: <426972E5.4000408@bushytails.net>
Message-ID: <Pine.LNX.4.62.0504230103310.26530@dragon.hyggekrogen.localhost>
References: <426972E5.4000408@bushytails.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2005, Randy Gardner wrote:

> I just bought a shiny new 16x dvd burner (box says IOMagic IDVD16DD, drive
> says Magicspin 1016IM), and can burn dvds perfectly...  just not read them.
[...]
> Apr 21 19:19:27 localhost kernel: hdf: command error: status=0x51 { DriveReady SeekComplete Error }
[...]

A shot in the dark; try enabling IDEDISK_MULTI_MODE in your kernel -  
the help text for that option : 

config IDEDISK_MULTI_MODE
        bool "Use multi-mode by default"
        help
          If you get this error, try to say Y here:

          hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
          hda: set_multmode: error=0x04 { DriveStatusError }

          If in doubt, say N.

Not the *exact* error you are getting, and I admit I don't know exactely 
what changes this option mkes, but the error seems similar enough to what 
that help text describes that personally I would give it a shot and see 
if it changes anything.


-- 
Jesper Juhl

