Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312345AbSDCTSE>; Wed, 3 Apr 2002 14:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312348AbSDCTRy>; Wed, 3 Apr 2002 14:17:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312345AbSDCTRn>;
	Wed, 3 Apr 2002 14:17:43 -0500
Message-ID: <3CAB551E.95990FBB@zip.com.au>
Date: Wed, 03 Apr 2002 11:16:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Maurice Volaski <mvolaski@aecom.yu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Mount corrupts an ext2 filesystem on a RAM disk
In-Reply-To: <a05100308b8d0e3b6a676@[129.98.91.150]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maurice Volaski wrote:
> 
> And in pre-5. Marcelo, I have never seen any feedback on this bug report.
> 

It works for me.

Please do this:

# cd
# mke2fs /dev/ram0 -m 0 -N 4096
# gzip < /dev/ram0 > before.gz
# mount /dev/ram0 /mnt/ram0
# umount /dev/ram0
# gzip < /dev/ram0 > after.gz 

and then send me your .config, before.gz and after.gz

Thanks.

-
