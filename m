Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTDVPO1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbTDVPO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:14:27 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:16522 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263205AbTDVPOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:14:23 -0400
Message-ID: <3EA55F20.4080708@blue-labs.org>
Date: Tue, 22 Apr 2003 11:26:24 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [OOPS] slap corruption, 2.5.66
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 924; timestamp 2003-04-22 11:26:28, message serial number 4173
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm putting 2.5.68 on shortly;

Slab corruption: start=c45b054c, expend=c45b060b, problemat=c45b05d8
Last user: [<c0193968>](d_callback+0x28/0x40)
Data: 
********************************************************************************************************************************************70 
43 27 C5 ***********************************************A5
Next: 71 F0 2C .68 39 19 C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `dentry_cache': object was 
modified after freeing
Call Trace:
 [<c0157a8b>] check_poison_obj+0x15b/0x1b0
 [<c01597f2>] kmem_cache_alloc+0x122/0x150
 [<c0195dee>] d_alloc+0x1e/0x3b0
 [<c0195dee>] d_alloc+0x1e/0x3b0
 [<c01881c6>] real_lookup+0x176/0x250
 [<c0188b0d>] do_lookup+0x8d/0xa0
 [<c0189232>] link_path_walk+0x712/0xdc0
 [<c015796b>] check_poison_obj+0x3b/0x1b0
 [<c01597f2>] kmem_cache_alloc+0x122/0x150
 [<c0189d3e>] __user_walk+0x3e/0x60
 [<c0182d4b>] vfs_lstat+0x1b/0x60
 [<c01833ab>] sys_lstat64+0x1b/0x40
 [<c010b0ab>] syscall_call+0x7/0xb


