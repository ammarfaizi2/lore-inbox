Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVEAC3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVEAC3U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 22:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVEAC3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 22:29:20 -0400
Received: from mail.dif.dk ([193.138.115.101]:36009 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261512AbVEAC3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 22:29:16 -0400
Date: Sun, 1 May 2005 04:32:45 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2 - /proc/ide/sr0/model: No such file or directory
In-Reply-To: <20050430164303.6538f47c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505010429050.2491@dragon.hyggekrogen.localhost>
References: <20050430164303.6538f47c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2005, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/
> 

I see one small change in behaviour with this kernel.

During boot when initializing udev I see 

Initializing udev dynamic device directory.
grep: /proc/ide/sr0/model: No such file or directory
grep: /proc/ide/sr1/model: No such file or directory

With previous kernels I only see

Initializing udev dynamic device directory.


This machine has no IDE device at all, only SCSI, and the kernel config 
has no IDE support either. The config I'm using has not changed in any 
ways that I think would cause this (it's the same as I used with 
2.6.12-rc2-mm3, just ran oldconfig on it and build the new kernel).


-- 
Jesper Juhl


