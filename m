Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbWBYMz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWBYMz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 07:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWBYMz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 07:55:59 -0500
Received: from mx1.suse.de ([195.135.220.2]:7059 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932705AbWBYMz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 07:55:58 -0500
Date: Sat, 25 Feb 2006 13:55:51 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org,
       Dave Johnson <djohnson+linux-kernel@sw.starentnetworks.com>
Subject: Re: cramfs mounts provide corrupted content since 2.6.15
Message-ID: <20060225125551.GA21203@suse.de>
References: <20060225110844.GA18221@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060225110844.GA18221@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Feb 25, Olaf Hering wrote: 
> 
> Any ideas why a cramfs mount provides empty files since at least 2.6.15?
> It worked ok in 2.6.13 at least. Bug is still present in Linus tree.

Reverting a97c9bf33f4612e2aed6f000f6b1d268b6814f3c (from 2.6.14-rc1)
does appearently fix it:
 [PATCH] fix cramfs making duplicate entries in inode cache

http://lkml.org/lkml/2006/2/25/48 for details
