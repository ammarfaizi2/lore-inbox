Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289796AbSAPAa1>; Tue, 15 Jan 2002 19:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289794AbSAPAaS>; Tue, 15 Jan 2002 19:30:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15109 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289795AbSAPAaJ>; Tue, 15 Jan 2002 19:30:09 -0500
Message-ID: <3C44C97D.9030106@zytor.com>
Date: Tue, 15 Jan 2002 16:29:49 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu> <E16Qa0W-0001kH-00@starship.berlin> <20020115140436.L11251@lynx.adilger.int> <E16Qcha-0001lF-00@starship.berlin> <20020115165951.R11251@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> 
> But the proposed cpio format (AFAIK) has ASCII numbers, which is what you
> were originally complaining about.  I see that cpio(1) says that "by
> default, cpio creates binary format archives... and can read archives
> created on machines with a different byte-order".
> 
> Excluding alignment issues (which can also be handled relatively easily),
> is there a reason why we chose the ASCII format over binary, especially
> since the binary format _appears_ to be portable (assuming endian
> conversions at decoding time), despite warnings to the contrary?
> 


The "binary" format of cpio is *ancient*.  There is no binary equivalent
to the "newc" (SVR4) format.

 
> The binary format reports lots of "truncating inode number", but for
> the purpose of initramfs, that is not an issue as we don't anticipate
> more than 64k files.  I don't know why the /sbin test is so heavily
> in favour of the newc (ASCII) format, but I repeated it to confirm
> the numbers.


There are way too many other problems with the ancient cpio formats.  Not
an option.

	-hpa


