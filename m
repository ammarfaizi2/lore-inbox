Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbVIBV2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbVIBV2w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbVIBV2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:28:51 -0400
Received: from dsl3-63-249-67-204.cruzio.com ([63.249.67.204]:25218 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S1161053AbVIBV2u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:28:50 -0400
Date: Fri, 2 Sep 2005 14:28:20 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200509022128.j82LSKUv006992@cichlid.com>
To: linux-kernel@vger.kernel.org
Cc: fxjrlists@yahoo.com.br
Subject: Re: Kernel 2.6.12 and 2.6.13 hangs for a while on boot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I'm having little hangs while booting with kernels 2.6.12 and 2.6.13-rc1, rc2
>and rc3.

>It is strange that 2.6.12-rc1 booted ok without hangs.

>Hangs appears just before mounting filesystems message and before configuring
>system to use udev.

I had a similar problem (intermittant) and narrowed it down to mod loading of
uhci-hcd so I blacklisted the module and loaded it later in rc.local where it
didn't hang.

Recently I tried unblacklisting it to see if it still hung and it did
not so you might try 2.6.13 final.

To narrow it down, edit rc.sysinit (depending on distribution) and make the
modprobes into modprobe -v

>I'm using 2.6.13 on a Gateway laptop.

Hmm, above you say 2.6.13-rc[1-3]
???

HTH

