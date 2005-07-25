Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVGYGsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVGYGsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVGYGqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 02:46:12 -0400
Received: from svr68.ehostpros.com ([67.15.48.48]:23767 "EHLO
	svr68.ehostpros.com") by vger.kernel.org with ESMTP id S261695AbVGYFy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:54:58 -0400
From: "Amit S. Kale" <amitkale@linsyssoft.com>
Organization: LinSysSoft Technologies Pvt Ltd
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: CheckFS: Checkpoints and Block Level Incremental Backup (BLIB)
Date: Mon, 25 Jul 2005 11:24:43 +0530
User-Agent: KMail/1.7
Cc: Pavel Machek <pavel@ucw.cz>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <200507231130.07208.amitkale@linsyssoft.com> <20050724142352.GB1778@elf.ucw.cz> <Pine.LNX.4.61.0507241713210.11580@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0507241713210.11580@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507251124.43898.amitkale@linsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr68.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linsyssoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 Jul 2005 8:44 pm, Jan Engelhardt wrote:
> >Maybe you want to put your development machines on ext*2* while doing
> >this ;-). Or perhaps reiserfs/xfs/something.
>
> Or perhaps into at the VFS level, so any fs can benefit from it.

We thought about that. While it's possible to do that, it would need hooks 
into all filesystems etc. Definitely worth trying once we get some more basic 
stuff working for ext3

After all the things that need to be saved at the time of taking a checkpoint 
for any filesystem would be the superblock and inode table (or their 
equivalents). Everything else is automatically taken care of.

-Amit
