Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130792AbQK3TYM>; Thu, 30 Nov 2000 14:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130073AbQK3TYC>; Thu, 30 Nov 2000 14:24:02 -0500
Received: from [212.187.250.66] ([212.187.250.66]:37387 "HELO
        proxy.jakinternet.co.uk") by vger.kernel.org with SMTP
        id <S131016AbQK3TKL>; Thu, 30 Nov 2000 14:10:11 -0500
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Andrew Morton
In-Reply-To: <UTC200011292154.WAA150996.aeb@aak.cwi.nl> <Pine.GSO.4.21.0011291716190.17068-100000@weyl.math.psu.edu> <3A26625E.446AE3D@uow.edu.au>
Subject: Re: corruption
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: 192.168.1.1
Message-ID: <b09.3a269edc.6bd12@trespassersw.daria.co.uk>
Date: Thu, 30 Nov 2000 18:39:24 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <3A26625E.446AE3D@uow.edu.au>,
	Andrew Morton <andrewm@uow.edu.au> writes:
AM> In thread "File corruption part deux", Lawrence Walton wrote:
>> 
>> my system has been acting slightly odd on all the pre 12 kernels
>> with the fs going read only with out any messages until now.
>> no opps or anything like that, but I did get this just now.
>> 
>> EXT2-fs error (device sd(8,2)): ext2_readdir:
>> bad entry in directory #458430: directory entry
>> across blocks - offset=152, inode=3393794200,
>> rec_len=12440, name_len=73
>>
AM> 
AM> 3393794200 == 0xca493098.  A kernel address. And 152 is 0x98,
AM> which is equal to N * 0x20 + 0x18. Read on...
AM> 

Don't know what these do for your analysis, observed on
2.4.0test12pre2, compiling mozilla. 

 EXT2-fs error (device ide0(3,11)):
   ext2_readdir: bad entry in directory #409870: directory entry across blocks
   - offset=88, inode=3284439128, rec_len=36952, name_len=196

 EXT2-fs error (device ide0(3,11)): 
   ext2_add_entry: bad entry in directory #344273: rec_len % 4 != 0 - offset=0, 
   inode=1769234798, rec_len=28271, name_len=85

Recompiling it with 2.4.0test12pre3 last night did not cause any fs
problems, at least that I've noticed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
