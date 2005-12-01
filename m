Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVLANxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVLANxN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVLANxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:53:13 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:50192 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932241AbVLANxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:53:12 -0500
Message-ID: <438F0039.9010801@argo.co.il>
Date: Thu, 01 Dec 2005 15:52:57 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Takashi Sato <sho@bsd.tnes.nec.co.jp>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp> <20051201125206.GB24519@wohnheim.fh-wedel.de>
In-Reply-To: <20051201125206.GB24519@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Dec 2005 13:53:08.0388 (UTC) FILETIME=[8F81AE40:01C5F67E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>On Thu, 1 December 2005 21:00:26 +0900, Takashi Sato wrote:
>  
>
>>diff -uprN -X linux-2.6.14.org/Documentation/dontdiff linux-2.6.14.or
>>g/include/asm-i386/stat.h linux-2.6.14-blocks/include/asm-i386/stat.h
>>--- linux-2.6.14.org/include/asm-i386/stat.h 2005-10-28 09:02:08.000000000 
>>+0900
>>+++ linux-2.6.14-blocks/include/asm-i386/stat.h 2005-11-18 
>>22:42:37.000000000 +0900
>>@@ -58,8 +58,7 @@ struct stat64 {
>> long long st_size;
>> unsigned long st_blksize;
>>
>>- unsigned long st_blocks; /* Number 512-byte blocks allocated. */
>>- unsigned long __pad4;  /* future possible st_blocks high bits */
>>+ unsigned long long st_blocks; /* Number 512-byte blocks allocated. */
>>    
>>
>
>After a closer look: have you tested this on a big-endian machine as
>well?  This heavily smells like it will work one one endianness only.
>
>  
>
It's in asm-i386, which is always little endian.
