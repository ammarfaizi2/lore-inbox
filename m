Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135616AbREBQD4>; Wed, 2 May 2001 12:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135612AbREBQDr>; Wed, 2 May 2001 12:03:47 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:60170 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135607AbREBQDk>; Wed, 2 May 2001 12:03:40 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3AF02FD3.617B8EB4@transmeta.com>
Date: Wed, 02 May 2001 09:03:31 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <3AEE4A06.3666F4BE@transmeta.com> <3AEFCAD0.BE2A5FA@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> "H. Peter Anvin" wrote:
> >
> > Hi guys,
> >
> > I was looking over the iso9660 code, and noticed that it was doing
> > endianness conversion via ad hoc *functions*, not even inlines; nor did
> > it take any advantage of the fact that iso9660 is bi-endian (has "all"
> > data in both bigendian and littleendian format.)
> >
> > The attached patch fixes both.  It is against 2.4.4, but from the looks
> > of it it should patch against -ac as well.
> 
> Please beware: There is a can of worms you are openning up here,
> since there are many broken CD producer programms out there, which
> only provide the little endian data and incorrect big endian
> entries. I had some CD's of this form myself. So the endian neutrality
> of the iso9660 is only in the theory present...
> 

So it has been discussed, and been updated.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
