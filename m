Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132562AbRDKLhI>; Wed, 11 Apr 2001 07:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132561AbRDKLg6>; Wed, 11 Apr 2001 07:36:58 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:30769 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S132559AbRDKLgk>; Wed, 11 Apr 2001 07:36:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: memory usage - dentry_cache
Date: Wed, 11 Apr 2001 13:36:15 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0104111336150G.25951@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To possbile answer my own question:
if I do a can on /proc/slabinfo I get  on the machine with "MISSING" memory:
---- 
slabinfo - version: 1.1 (SMP)
--- cut out
inode_cache       920558 930264    480 116267 116283    1 :  124   6
--- cut out
dentry_cache      557245 638430    128 21281 21281    1 :  252  126


while on an equivalent server I get 
----
labinfo - version: 1.1 (SMP)

inode_cache        70464  70464    480 8808 8808    1 :  124   62

dentry_cache       72900  72900    128 2430 2430    1 :  252  126

----

Notice the huge size of the inode and dentry caches. bareing in mind that 
both have 85GIG Reiserfs Home filesystems. 
The first machine has a many of directories containing many thousands for 
files. 
BTW could anyone enlighten me to the exact meaning of the values in the 
slabinfo gile.

Regards
MarCin



> I can use "ps" to see memory usage of daemons and user programs.
> I can't find any memory information of kernel with "top" and "ps".
>
> Do you know how to take memory usage information of kernel ?
> Thanks for your help.

Regarding this issue, I have a similar problem if I do a free on my system I
get :
---   total       used       free     shared    buffers     cached
Mem:       1157444    1148120       9324          0      22080     459504
-/+ buffers/cache:     666536     490908
Swap:       641016      19072     621944
---
Now what I do a ps there seems no way to accound for the 500mb + of memory
used. No single or group of processes uses that amount of memory. THis is
very disconcerting, coupled with extremely high loads when cache is dumped to
disk locking up the machine makes me want to move back to 2.2.19 from 2.4.3.

I would also be curious to see how the kernel is using memory...

TIA
MARCin


--
-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-------------------------------------------------------

-- 
-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
