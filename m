Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVKPRvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVKPRvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVKPRvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:51:01 -0500
Received: from gold.veritas.com ([143.127.12.110]:24458 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030287AbVKPRvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:51:00 -0500
Date: Wed, 16 Nov 2005 17:49:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Thomas Cort <linuxgeek@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Xorg is using MAP_PRIVATE, PROT_WRITE mprotect of VM_RESERVED
 memory
In-Reply-To: <3b09e8e90511160505q56b1dd48wd554a5cbdb9a247@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0511161748030.11170@goblin.wat.veritas.com>
References: <3b09e8e90511160505q56b1dd48wd554a5cbdb9a247@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Nov 2005 17:51:00.0464 (UTC) FILETIME=[4E216700:01C5EAD6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005, Thomas Cort wrote:

> I tried running "Xorg -configure" on my alpha (EV56) with Linux kernel
> 2.6.15-rc1 and got the following error message: "xf86EnableIOPorts:
> Failed to set IOPL for I/O". I checked the kernel log and found the
> following error message:
> 
> Nov 16 06:38:49 [kernel] [4394179.238460] program Xorg is using
> MAP_PRIVATE, PROT_WRITE mprotect of VM_RESERVED memory, which is
> deprecated. Please report this to linux-kernel@vger.kernel.org
> 
> If you need any further information or would like me to test anything,
> feel free to contact me.

Thanks a lot for the report: I'm finishing up on patches to fix this
and some other related problems, hope they'll be in time for -rc2.

Hugh
