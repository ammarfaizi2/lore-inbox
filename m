Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269145AbTCDJHk>; Tue, 4 Mar 2003 04:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269161AbTCDJHk>; Tue, 4 Mar 2003 04:07:40 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:12815 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S269145AbTCDJHj>; Tue, 4 Mar 2003 04:07:39 -0500
Message-ID: <3E646FB0.6040108@aitel.hist.no>
Date: Tue, 04 Mar 2003 10:19:44 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.63-mm2 slab corruption
References: <20030302180959.3c9c437a.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.63-mm2 seems to work fine, but I got this in my dmesg:
Helge Hafting

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 320k freed
Adding 1999864k swap on /dev/hdb2.  Priority:-1 extents:1
eth0: no IPv6 routers present
Slab corruption: start=d714cfa4, expend=d714cfe3, problemat=d714cfba
Data: **********************7B ****************************************A5
Next: 71 F0 2C .B8 2F 18 08 14 00 00 00 F7 01 55 55 03 00 00 00 21 3D 00 
03 00 0
0 00 00 74 69 6D 65
slab error in check_poison_obj(): cache `vm_area_struct': object was 
modified af
ter freeing
Call Trace:
  [<c0130711>] __slab_error+0x21/0x28
  [<c01308db>] check_poison_obj+0x103/0x10c
  [<c013197c>] kmem_cache_alloc+0x64/0xe8
  [<c01393a4>] split_vma+0x2c/0xdc
  [<c01394ea>] do_munmap+0x96/0x134
  [<c01395bf>] sys_munmap+0x37/0x54
  [<c0108b17>] syscall_call+0x7/0xb

Slab corruption: start=c3eca854, expend=c3eca893, problemat=c3eca86a
Data: **********************7B ****************************************A5
Next: 71 F0 2C .A5 C2 0F 17 F0 E7 29 D8 00 A0 D9 41 00 A0 DB 41 C4 A7 EC 
C3 25 0
0 00 00 77 00 10 00
slab error in check_poison_obj(): cache `vm_area_struct': object was 
modified af
ter freeing
Call Trace:
  [<c0130711>] __slab_error+0x21/0x28
  [<c01308db>] check_poison_obj+0x103/0x10c
  [<c013197c>] kmem_cache_alloc+0x64/0xe8
  [<c01393a4>] split_vma+0x2c/0xdc
  [<c01394ea>] do_munmap+0x96/0x134
  [<c01395bf>] sys_munmap+0x37/0x54
  [<c0108b17>] syscall_call+0x7/0xb

