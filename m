Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132462AbREBJFg>; Wed, 2 May 2001 05:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132465AbREBJF0>; Wed, 2 May 2001 05:05:26 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36619 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132462AbREBJFO>; Wed, 2 May 2001 05:05:14 -0400
Message-ID: <3AEFCAD0.BE2A5FA@evision-ventures.com>
Date: Wed, 02 May 2001 10:52:32 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andries Brouwer <Andries.Brouwer@cwi.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <3AEE4A06.3666F4BE@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Hi guys,
> 
> I was looking over the iso9660 code, and noticed that it was doing
> endianness conversion via ad hoc *functions*, not even inlines; nor did
> it take any advantage of the fact that iso9660 is bi-endian (has "all"
> data in both bigendian and littleendian format.)
> 
> The attached patch fixes both.  It is against 2.4.4, but from the looks
> of it it should patch against -ac as well.

Please beware: There is a can of worms you are openning up here, 
since there are many broken CD producer programms out there, which
only provide the little endian data and incorrect big endian
entries. I had some CD's of this form myself. So the endian neutrality
of the iso9660 is only in the theory present...
