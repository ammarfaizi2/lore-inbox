Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265558AbUEZMml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265558AbUEZMml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265560AbUEZMmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:42:40 -0400
Received: from 0x63.nu ([62.65.122.157]:36322 "EHLO gagarin.0x63.nu")
	by vger.kernel.org with ESMTP id S265558AbUEZMmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:42:19 -0400
Date: Wed, 26 May 2004 14:41:58 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.6-mm5
Message-ID: <20040526124158.GA3679@h55p111.delphi.afb.lu.se>
References: <20040522013636.61efef73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522013636.61efef73.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *1BSxjK-00016g-00*0z9MH1DEI0Y*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 01:36:36AM -0700, Andrew Morton wrote:
> 
> - Implementation of request barriers for IDE and SCSI.  The idea here is
>   that a filesystem can tag an IO request as a barrier and the disk will not
>   reorder writes across the barrier.  It provides additional integrity
>   guarantees for the journalling filesystems.  The feature is enabled for
>   reiserfs and ext3.

I get: this error message when using barriers on a scsi disk:

lost page write due to I/O error on sdb1
JBD: barrier-based sync failed on sdb1 - bisabling barriers

and I don't want them barriers bisabled :)

ext3 filesystem. reiser also disables barriers.

I have a "Adaptec AIC-7902 U320 (rev 3)" SCSI controller and the disk is a
SEAGATE ST373307LW.

It works on ide.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
