Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWHWLSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWHWLSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWHWLSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:18:30 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:47039 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S964883AbWHWLSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:18:30 -0400
Date: Wed, 23 Aug 2006 13:18:15 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, Balbir Singh <balbir@in.ibm.com>
Subject: Re: oops in __delayacct_blkio_ticks with 2.6.18-rc4
Message-ID: <20060823111815.GA11270@aepfle.de>
References: <20060821112405.GA28356@aepfle.de> <44EB5684.60002@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44EB5684.60002@watson.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, Shailabh Nagar wrote:

> Olaf Hering wrote:
> > https://bugzilla.novell.com/show_bug.cgi?id=200526
> >
> 
> Thanks for detecting this.
> 
> I suspect the oops is caused by a reading of /proc/<tgid>/stat for some task
> that is late in exit. Currently tsk->delays is being freed up too early (before
> the tsk is removed from the tasklist).
> 
> Could you try the patch below ? It was unclear from the bug what userspace
> actions were being done to reproduce the oops - I suspect some kind of
> reading of /proc/.../stat for all processes ?

I dont have a way to trigger it. The commands were 'w' and 'pstree'.
