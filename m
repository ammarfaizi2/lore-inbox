Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273739AbRIQWdN>; Mon, 17 Sep 2001 18:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273726AbRIQWcA>; Mon, 17 Sep 2001 18:32:00 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:29701 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S273722AbRIQWbk>; Mon, 17 Sep 2001 18:31:40 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
In-Reply-To: <9o5pfu$f03$1@ns1.clouddancer.com>
In-Reply-To: <20010917151957.A26615@codepoet.org> <9o5pfu$f03$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010917223203.DACE3783EE@mail.clouddancer.com>
Date: Mon, 17 Sep 2001 15:32:03 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, andersen@codepoet.org wrote:
>
>[----------snip----------]
>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
>        <Adaptec 2940 Ultra SCSI adapter>
>        aic7880: Ultra Single Channel A, SCSI Id=7, 16/255 SCBs
...
>$ cat /proc/partitions
>major minor  #blocks  name
>
>   8     0     620704 sda
>   8    16     620704 sdb
>   8     0     620704 sda
>   8    16     620704 sdb
>   8     0     620704 sda
>   8    16     620704 sdb
>   8     0     620704 sda
>   8    16     620704 sdb
>   8     0     620704 sda
>   8    16     620704 sdb
>   8     0     620704 sda
>   8    16     620704 sdb
>   8     0     620704 sda
>   8    16     620704 sdb
>   <continues forever>


Works fine here:

Linux ns1.clouddancer.com 2.4.9-ac10 #1 SMP Tue Sep 11 21:47:15 PDT
2001 i686 unknown


 }cat /proc/partitions
major minor  #blocks  name

   9     0   53347584 md0
   8     0    8891620 sda
   8     1    4060160 sda1
   8     2    4403200 sda2
   8     3      34800 sda3
   8     4     393216 sda4
   8    16    8891620 sdb
   8    17    8891376 sdb1
   8    32    8891620 sdc
   8    33    8891376 sdc1
   8    48    8891620 sdd
   8    49    8891376 sdd1
   8    64    8891620 sde
   8    65    8891376 sde1
   8    80    8891620 sdf
   8    81    8891376 sdf1
   8    96    8891620 sdg
   8    97    8891376 sdg1
   8   112    8891620 sdh
   8   113    8891376 sdh1


SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 9, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Symbios NVRAM
sym53c8xx: at PCI bus 0, device 9, function 1


Perhaps it is a driver effect?

-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."

