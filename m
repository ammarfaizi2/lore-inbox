Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264594AbRFYPFJ>; Mon, 25 Jun 2001 11:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbRFYPE7>; Mon, 25 Jun 2001 11:04:59 -0400
Received: from babel.spoiled.org ([212.84.234.227]:22204 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S264594AbRFYPEt>;
	Mon, 25 Jun 2001 11:04:49 -0400
Date: 25 Jun 2001 15:04:47 -0000
Message-ID: <20010625150447.17109.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: phillips@bonn-fries.net (Daniel Phillips)
Cc: linux-kernel@vger.kernel.org
Subject: Re: FAT32 superiority over ext2 :-)
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <0106250203070J.00430@starship>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0106250203070J.00430@starship> you wrote:
> On Monday 25 June 2001 01:49, Albert D. Cahalan wrote:
>> Daniel Phillips writes:
>> > On Monday 25 June 2001 00:54, Albert D. Cahalan wrote:
>> >> By dumb luck (?), FAT32 is compatible with the phase-tree algorithm
>> >> as seen in Tux2. This means it offers full data integrity.
>> >> Yep, it whips your typical journalling filesystem. Look at what
>> >> we have in the superblock (boot sector):
>> >>
>> >>     __u32  fat32_length;  /* sectors/FAT */
>> >>     __u16  flags;         /* bit 8: fat mirroring, low 4: active fat */
>> >>     __u8   version[2];    /* major, minor filesystem version */
>> >>     __u32  root_cluster;  /* first cluster in root directory */
>> >>     __u16  info_sector;   /* filesystem info sector */
>> >>
>> >> All in one atomic write, one can...
>> >>
>> >> 1. change the active FAT
>> >> 2. change the root directory
>> >> 3. change the free space count
>> >>
>> >> That's enough to atomically move from one phase to the next.
>> >> You create new directories in the free space, and make FAT
>> >> changes to an inactive FAT copy. Then you write the superblock
>> >> to atomically transition to the next phase.

[--snip--]

> When can we expect the patch?

Don't! Blasphemy!!!

Juri ;-) 

-- 
Juri Haberland  <juri@koschikode.com> 

