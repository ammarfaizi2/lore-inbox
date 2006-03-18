Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWCRNRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWCRNRu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 08:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWCRNRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 08:17:50 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:18175 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932338AbWCRNRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 08:17:49 -0500
Message-ID: <00e801c64a8e$4f5a3080$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Andreas Dilger" <adilger@clusterfs.com>
Cc: "Badari Pulavarty" <pbadari@gmail.com>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "ext2-devel" <Ext2-devel@lists.sourceforge.net>
References: <000401c6482d$880adfa0$4168010a@bsd.tnes.nec.co.jp> <1142630359.15257.30.camel@dyn9047017100.beaverton.ibm.com> <00e801c64a50$e4c82980$4168010a@bsd.tnes.nec.co.jp> <20060318101102.GZ30801@schatzie.adilger.int>
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support 2^32-1blocks(e2fsprogs)
Date: Sat, 18 Mar 2006 22:17:25 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Mar 18, 2006  14:57 +0900, Takashi Sato wrote:
>> >elm3b29:~/e2fsprogs-1.38/misc # ./mke2fs /dev/md0
>> >mke2fs 1.38 (30-Jun-2005)
>> >mke2fs: Filesystem too large.  No more than 2**31-1 blocks
>> >        (8TB using a blocksize of 4k) are currently supported.
>> >
>> >When I try to create "ext3":
>> 
>> As I said in my previous mail, You should specify -F option to
>> create ext2/3 which has more than 2**31-1 blocks.
>> It is because of the compatibility.
> 
> Oh, using -F for this is highly dangerous.  That would allow mke2fs to
> run on e.g. a mounted filesystem or something.  Instead use an option
> like "-E 16tb" or something.

I would like to integrate the function into new option "-O large_block"
in my mail "[PATCH 1/4] ext2/3: Extends the max file size(ext2 in kernel)".
