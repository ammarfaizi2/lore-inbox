Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVBFTNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVBFTNR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVBFTM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:12:56 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:30614 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261288AbVBFTBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:01:14 -0500
Date: Sun, 6 Feb 2005 20:01:20 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Neil Conway <nconway_kernel@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3TB disk hassles
In-Reply-To: <20050206105958.42872.qmail@web26501.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.58.0502061951400.2730@be1.lrz>
References: <20050206105958.42872.qmail@web26501.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Feb 2005, Neil Conway wrote:

> Since writing the above, I've been searching for more info.  I
> downloaded four different versions of grub (GNU Grub Legacy, GNU Grub2,
> gentoo and Fedora Core 3).  NONE of these showed any evidence of GPT
> support (I was in a hurry, so I searched for strings EFI, GUID, GPT,
> TB).

I'd use lilo in that case. AFAI understood it can start from any device
provided the BIOS can access the boot files. (May require a 5MB /boot 
partition if the disk is larger than the BIOS can access)

HTH

> I fail to see how grub can work on a GPT boot device if it can't parse
> the partition table.  I conclude that I'm still missing something. 
> Perhaps a layer before grub is supposed to parse the GPT instead?  If
> so, isn't that getting us straight back to a GPT-aware BIOS?

If grub parses the partition table, it will do that without any BIOS
support (except maybe for reading the raw data). So even a GPT-aware BIOS
should not change a thing.

-- 
Funny quotes:
23. If at first you don't succeed, destroy all evidence that you tried.
