Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbULMVDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbULMVDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbULMVDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:03:11 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:21140 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261340AbULMVBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:01:23 -0500
Date: Mon, 13 Dec 2004 22:01:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: how to detect a 32 bit process on 64 bit kernel
In-Reply-To: <20041213195011.GA24053@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0412132159360.32588@yvahk01.tjqt.qr>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de>
 <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de>
 <20041212215110.GA11451@mellanox.co.il> <20041212222309.GA11045@infradead.org>
 <20041213195011.GA24053@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > If no - would not it make a sence to add e.g. a flag in the
>> > task struct, to make it possible?
>> 
>> The kernel code shouldn't know.  If your driver needs this information
>> something is seriously wrong with it. 
>
>A character driver I am working on gets passed a structure
>from user space by implementing a write file operation.
>The structure includes a pointer and so the format varies
>between a 32 and 64 bit processes.

Do it like Glibc does. Use uint32_t and uint64_t when transferring things 
to/from kernelspace.



Jan Engelhardt
-- 
ENOSPC
