Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289844AbSAPDeL>; Tue, 15 Jan 2002 22:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289842AbSAPDeB>; Tue, 15 Jan 2002 22:34:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61708 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289844AbSAPDdt>; Tue, 15 Jan 2002 22:33:49 -0500
Message-ID: <3C44F484.4080204@zytor.com>
Date: Tue, 15 Jan 2002 19:33:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu> <E16Qa0W-0001kH-00@starship.berlin> <20020115140436.L11251@lynx.adilger.int> <E16Qcha-0001lF-00@starship.berlin> <20020115165951.R11251@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>> 
> Well, a few quick tests show (GNU cpio version 2.4.2), with raw sizes
> in "blocks" as output by cpio, compressed sizes in bytes:
> 
> find <dir> | cpio -o -H <format> | gzip -9 | wc -c
> 
> dir		  bin (default)		newc (proposed)
> 		  raw	   gzip		  raw	   gzip
> /sbin		15121	3289678		12952	2769451
> /etc		 8822	 689517		 8996	 693700
> /usr/local/sbin	 1895	 385461		 1899	 385764
> 
> The binary format reports lots of "truncating inode number", but for
> the purpose of initramfs, that is not an issue as we don't anticipate
> more than 64k files.  I don't know why the /sbin test is so heavily
> in favour of the newc (ASCII) format, but I repeated it to confirm
> the numbers.
> 


Probably because it does hard links.

	-hpa


