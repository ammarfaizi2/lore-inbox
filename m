Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWFOJvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWFOJvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWFOJvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:51:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:35003 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932415AbWFOJvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:51:54 -0400
Date: Thu, 15 Jun 2006 11:51:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: squashfs size in statfs
In-Reply-To: <e62cs9$csl$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.61.0606151151020.9572@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0606051243100.579@yvahk01.tjqt.qr>
 <e62cs9$csl$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hello list,
>> 
>> 
>> # l /mnt
>> total 36293
>> drwxr-xr-x   2 root root       20 Jun  5 11:50 .
>> drwxr-xr-x  31 root root     4096 Jun  5  2006 ..
>> -rw-r--r--   1 root root 37158912 Jun  5 11:06 mem
>> # df
>> Filesystem           1K-blocks      Used Available Use% Mounted on
>> /dev/shm/sc.sqfs         26688     26688         0 100% /mnt
>> # l sc.sqfs
>> -rwx------  1 jengelh users 27279360 Jun  5 11:50 sc.sqfs
>> 
>> I think statfs() should show the uncompressed size, no?
>
>No.
>
Yes, because CRAM does it that way, and maybe zisofs does it too:

11:50 shanghai:/dev/shm # mount out.cram /mnt -oloop,ro
11:50 shanghai:/dev/shm # df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/shm/out.cram        14336     14336         0 100% /mnt
11:50 shanghai:/dev/shm # l out.cram
-rw-r--r--  1 root root 110592 Jun 15 11:50 out.cram



Jan Engelhardt
-- 
