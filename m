Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268978AbUIQUja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268978AbUIQUja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268979AbUIQUiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:38:50 -0400
Received: from [209.195.52.120] ([209.195.52.120]:8354 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S268982AbUIQUgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:36:51 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Valdis.Kletnieks@vt.edu
Cc: Eric Mudama <edmudama@gmail.com>, David Stevens <dlstevens@us.ibm.com>,
       Netdev <netdev@oss.sgi.com>, leonid.grossman@s2io.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Date: Fri, 17 Sep 2004 13:36:14 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: The ultimate TOE design 
In-Reply-To: <200409172027.i8HKRVwY005444@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.60.0409171333510.24478@dlang.diginsite.com>
References: <4148991B.9050200@pobox.com>
 <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com><311601c90409162346184649eb@mail.gmail.com>
 <200409172027.i8HKRVwY005444@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

actually the sector based access that is made to modern drives is a very 
primitive filesystem. if you go back to the days of the MFM and RLL drives 
you had the computer sending the raw bitstreams to the drives, but with 
SCSI and IDE this stopped and you instead a higher level logical block to 
the drive and it deals with the details of getting it to and from the 
platter.

David Lang

On Fri, 17 Sep 2004 Valdis.Kletnieks@vt.edu wrote:

> Date: Fri, 17 Sep 2004 16:27:31 -0400
> From: Valdis.Kletnieks@vt.edu
> To: Eric Mudama <edmudama@gmail.com>
> Cc: David Stevens <dlstevens@us.ibm.com>, Netdev <netdev@oss.sgi.com>,
>     leonid.grossman@s2io.com, Linux Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: The ultimate TOE design 
> 
> On Fri, 17 Sep 2004 00:46:59 MDT, Eric Mudama said:
>> On Wed, 15 Sep 2004 14:11:04 -0600, David Stevens <dlstevens@us.ibm.com> wrot
> e:
>>> Why don't we off-load filesystems to disks instead?
>>
>> Disks have had file systems on them since close to the beginning...
>
> No, he means "offload the processing of the filesystem to the disk itself".
>
> IBM's MVS  systems basically did that - it used the disk's "Search Key" I/O
> opcodes to basically get the equivalent of doing namei() out on the disk itself
> (it did this for system catalog and PDS directory searches from the beginning,
> and added 'indexed VTOC' support in the mid-80s).  So you'd send out a CCW
> (channel command word) stream that basically said "Find me the dataset
> USER3.ACCTING.TESTJOBS", and when the I/O completed, you'd have the DSCB (the
> moral equiv of an inode) ready to go.
>
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
