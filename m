Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTDPJhW (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 05:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbTDPJhW 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 05:37:22 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:3723 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S264275AbTDPJhV (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 05:37:21 -0400
Date: Wed, 16 Apr 2003 05:45:20 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304160548_MC3-1-349F-E843@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It opens sd twice (AFAIK) - I think mount scans the block devices (an open
> of sd) and then mounts (internal open). The code path in question is
> probably via sd.c functions sd_media_changed and sd_revalidate_disk, and
> the block_dev.c check_disk_change. sd_open calls check_disk_change.
>
> This could be the same problem others are seeing with removable media
> accessed via USB mass storage.


  I was seeing problems with ide-floppy on 2.5.66.  It kept
trying to re-register the disk, AFAICT... and there were different
errors depending on whether I booted with a disk in the drive.  (The
drive was removed, so I can't test anything now.)


--
 Chuck
