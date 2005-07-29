Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVG2Her@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVG2Her (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbVG2Her
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:34:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64211 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262479AbVG2Heq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:34:46 -0400
Date: Fri, 29 Jul 2005 09:36:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setting task->ioprio from a kernel thread
Message-ID: <20050729073643.GE22569@suse.de>
References: <42E5BC9C.8060803@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E5BC9C.8060803@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25 2005, Zach Brown wrote:
> 
> In OCFS2 there is currently an in-kernel heartbeat thread that really 
> wants to communicate liveness to other nodes as quickly as possible by 
> writing to a block device.  Setting aside the specific wisdom of a 
> kernel heartbeat thread for a bit, has it been considered that kernel 
> threads might want to set their io priority with the task->ioprio bits? 
>  Neither set_task_ioprio() nor sys_ioprio_set() seem to be accessible 
> to modules and open-coding it is clearly a bad idea.  Would the universe 
> be opposed to a _GPL() export of, say, the sys_() interface?

I guess the sys_get/set export would be ok, although it seems a little
nasty to export the actual syscalls.

-- 
Jens Axboe

