Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283054AbSAEUla>; Sat, 5 Jan 2002 15:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283012AbSAEUlK>; Sat, 5 Jan 2002 15:41:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30483 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283003AbSAEUlE>; Sat, 5 Jan 2002 15:41:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel patch support large fat partitions
Date: 5 Jan 2002 12:40:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a17ocj$qr5$1@cesium.transmeta.com>
In-Reply-To: <5.1.0.14.0.20020103152205.039f2008@mage.qualcomm.com> <5.1.0.14.0.20020104104826.03a15978@mage.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <5.1.0.14.0.20020104104826.03a15978@mage.qualcomm.com>
By author:    Vijay Kumar <jkumar@qualcomm.com>
In newsgroup: linux.dev.kernel
> 
> Using 28bit cluster numbers and 65536 cluster size I could go upto 16TB 
> which is lot more than what I wanted. So right now I have no problem with 
> the on-disk format of a fat partition. Nevertheless with hard drives prices 
> going down dramatically it may not be too long before we hit the limit.
> 
> Regards,
> - Vijay
> 

That's Microsoft's problem -- that's a fundamental limit of the format
they defined.  The fact that they defined it in the first place is
part of the problem (the only way you can make a FAT filesystem work
*well* is by loading the entire FAT into memory ahead of time, and
"FAT32" breaks that), instead of creating a more sensible
replacement.

(FWIW, the reason they used to justify FAT32 was "it would be too much
work to make DOS handle NTFS", as if those were the only options...)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
