Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWEUJXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWEUJXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 05:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWEUJXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 05:23:42 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:41098 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751502AbWEUJXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 05:23:42 -0400
Message-ID: <013c01c67cb8$2d8b2c00$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org>
Subject: Re: swapper: page allocation failure.
Date: Sun, 21 May 2006 11:23:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Chris Wedgwood" <cw@f00f.org>
To: "Haar J?nos" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 21, 2006 10:47 AM
Subject: Re: swapper: page allocation failure.


> On Sun, May 21, 2006 at 10:37:00AM +0200, Haar J?nos wrote:
>
> >              total       used       free     shared    buffers
cached
> > Mem:       2073048     893360    1179688          0     829092
19820
> > Low:        893464     868352      25112          0          0
0
> > High:      1179584      25008    1154576          0          0
0
> > -/+ buffers/cache:      44448    2028600
> > Swap:            0          0          0
>
> looks bad for lowmem
>
> what does /proc/meminfo say?
>
> what about the output from "slabtop -sc" ?

Here comes:

 Active / Total Objects (% used)    : 243896 / 258956 (94.2%)
 Active / Total Slabs (% used)      : 6243 / 6261 (99.7%)
 Active / Total Caches (% used)     : 76 / 151 (50.3%)
 Active / Total Size (% used)       : 20769.86K / 23348.68K (89.0%)
 Minimum / Average / Maximum Object : 0.01K / 0.09K / 128.00K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
208872 206768  98%    0.05K   2901       72     11604K buffer_head
  4960   4051  81%    0.68K    992        5      3968K nfs_inode_cache
  9996   6478  64%    0.27K    714       14      2856K radix_tree_node
   566    530  93%    2.00K    283        2      1132K size-2048
  4680   4014  85%    0.12K    156       30       624K dentry_cache
  1430   1409  98%    0.39K    143       10       572K inode_cache
    65     65 100%    8.00K     65        1       520K size-8192
   258    256  99%    1.32K     86        3       344K raid5/md0
  5460   5435  99%    0.04K     65       84       260K sysfs_dir_cache
   945    882  93%    0.25K     63       15       252K size-256
   456    438  96%    0.50K     57        8       228K size-512
  2891   2514  86%    0.06K     49       59       196K size-64
   675    474  70%    0.25K     45       15       180K skbuff_head_cache
   176    165  93%    1.00K     44        4       176K size-1024
  1320    744  56%    0.12K     44       30       176K bio
    42     37  88%    4.00K     42        1       168K size-4096
  1170   1073  91%    0.12K     39       30       156K size-128
   351    316  90%    0.40K     39        9       156K proc_inode_cache
  4068   3298  81%    0.03K     36      113       144K size-32
   660    160  24%    0.19K     33       20       132K filp
    84     64  76%    1.30K     28        3       112K task_struct
  1232    441  35%    0.09K     28       44       112K vm_area_struct
    69     63  91%    1.31K     23        3        92K sighand_cache
    20     20 100%    4.00K     20        1        80K pgd
   396    244  61%    0.17K     18       22        72K blkdev_requests
     1      1 100%   64.00K      1        1        64K size-65536
   160    153  95%    0.38K     16       10        64K skbuff_fclone_cache
    32     32 100%    2.00K     16        2        64K sgpool-128
    15      3  20%    4.00K     15        1        60K names_cache
  1196   1138  95%    0.04K     13       92        52K acpi_operand
  2639    640  24%    0.02K     13      203        52K biovec-1
    12     11  91%    3.00K      6        2        48K biovec-(256)
   180    162  90%    0.25K     12       15        48K sgpool-16
    96     82  85%    0.50K     12        8        48K sgpool-32
   110     64  58%    0.38K     11       10        44K signal_cache
    40     37  92%    0.97K     10        4        40K blkdev_queue
    32     32 100%    1.00K      8        4        32K sgpool-64
    80     80 100%    0.38K      8       10        32K scsi_cmd_cache
   413    263  63%    0.06K      7       59        28K as_arq
   180    150  83%    0.12K      6       30        24K kmem_cache
    54     20  37%    0.44K      6        9        24K mm_struct
    15     15 100%    1.50K      3        5        24K biovec-128
   180    180 100%    0.12K      6       30        24K sgpool-8
    42     36  85%    0.50K      6        7        24K nfs_write_data
   505     64  12%    0.04K      5      101        20K pid
    50     21  42%    0.38K      5       10        20K files_cache
   145    112  77%    0.13K      5       29        20K idr_layer_cache
    35     26  74%    0.56K      5        7        20K bdev_cache
    35     23  65%    0.50K      5        7        20K sock_inode_cache
    25     23  92%    0.75K      5        5        20K biovec-64
    35     32  91%    0.50K      5        7        20K nfs_read_data

Cheers,
Janos

