Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313661AbSD3QNB>; Tue, 30 Apr 2002 12:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313680AbSD3QNA>; Tue, 30 Apr 2002 12:13:00 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:9992 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S313661AbSD3QM7>; Tue, 30 Apr 2002 12:12:59 -0400
Message-ID: <3CCEC275.4000707@loewe-komp.de>
Date: Tue, 30 Apr 2002 18:12:37 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: john slee <indigoid@higherplane.net>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <5.1.0.14.2.20020427191820.04003500@pop.cus.cam.ac.uk> <5.1.0.14.2.20020429115231.00b1d900@pop.cus.cam.ac.uk> <15565.13742.140693.146727@laputa.namesys.com> <200204301217.g3UCGtX02871@Port.imtp.ilyichevsk.odessa.ua> <20020430131523.GA22705@higherplane.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee wrote:
> [ cc list trimmed ]
> 
> On Tue, Apr 30, 2002 at 03:19:17PM -0200, Denis Vlasenko wrote:
> 
>>Why do we have to stich to concept of inode *numbers*?
>>Because there are inode numbers in traditional Unix filesystems?
>>
> 
> probably because there is software out there relying on them being
> numbers and being able to do 'if(inum_a == inum_b) { same_file(); }'
> as appropriate.  i can't think of a use for such a construct other than
> preserving hardlinks in archives (does tar do this?) but i'm sure there
> are others
> 
> like much of unix it's been there forever and has become such a natural
> concept in people's heads that to change it now seems unthinkable.
> 
> much like the missing e in creat().
> 

No. Not supplying inode numbers would break unix semantics.
The kernel (and binary loader) depends on a unique key:

major:minor device number + inode


Otherwise: how to decide if a shared object is the same?
checksuming? ;-)

But what would be different with characters? Despite more complexity?


