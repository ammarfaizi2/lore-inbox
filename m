Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262758AbTCJIgA>; Mon, 10 Mar 2003 03:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbTCJIfs>; Mon, 10 Mar 2003 03:35:48 -0500
Received: from h-64-105-35-31.SNVACAID.covad.net ([64.105.35.31]:22413 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262758AbTCJIfb>; Mon, 10 Mar 2003 03:35:31 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 10 Mar 2003 00:46:05 -0800
Message-Id: <200303100846.AAA09348@baldur.yggdrasil.com>
To: mbligh@aracnet.com
Subject: Re: 2.5.64bk5: X86_PC + HIGHMEM boot failure
Cc: gone@us.ibm.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Mar 2003, Martin J. Bligh wrote:

>> 	Under linux-2.5.64bk5, CONFIG_X86_PC sets CONFIG_NUMA,
>> which sets CONFIG_DISCONTIGMEM.  This causes the version of
>> set_max_mapnr_init in arch/i386/mm/discontig.c to be compiled
>> in (instead of the one from arch/i386/mm/init.c):
>>
>> Err, I meant 2.5.64bk4. 

>Hmmm ... well I don't see bk4 on ftp.kernel.org,

	I meant ftp://ftp.kernel.org/pub/liux/kernel/v2.5/linux-2.5.64.tar.gz
patched with
ftp://ftp.kernel.org/pub/liux/kernel/v2.5/snapshots/patch-2.5.64-bk4.gz.

>but the same
>changes are in my tree ...  I've just checked it, and it doesn't 
>do that for me. It should *allow* you to turn on CONFIG_NUMA 
>(and that might be broken for PCs still) but it shouldn't be on 
>by default ... could you check that you can still disable it?
>Works for me ...

	Oops.  You're right it is possible to deactivate
CONFIG_NUMA in this kernel under X86_PC, and that avoids
the problem.  I guess there still is the minor issue that
either CONFIG_NUMA should work with X86_PC + HIGHMEM (even
on machines without high memory) or else CONFIG_NUMA
should not be selectable in this case, but that's obviously
a bug of much less importance.

	Sorry for my misunderstanding of the CONFIG_NUMA configution
options.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


