Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289665AbSAOUOU>; Tue, 15 Jan 2002 15:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290271AbSAOUOL>; Tue, 15 Jan 2002 15:14:11 -0500
Received: from [66.89.142.2] ([66.89.142.2]:54836 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S289665AbSAOUOB>;
	Tue, 15 Jan 2002 15:14:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs buffer spec -- second draft
Date: Tue, 15 Jan 2002 21:16:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu> <E16QXbx-0000wa-00@starship.berlin> <3C448B01.6030003@zytor.com>
In-Reply-To: <3C448B01.6030003@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Qa0W-0001kH-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 15, 2002 09:03 pm, H. Peter Anvin wrote:
> Daniel Phillips wrote:
> 
> > 
> > Encoding the numeric fields in ASCII/hex is a goofy wart on an otherwise 
nice 
> > design.  What is the compelling reason?  Bytesex isn't it: we should just 
> > pick one or the other and stick with it as we do in Ext2.
> > 
> > Why don't we fix cpio to write a consistent bytesex?
> > 
> 
> 
> Because we want to use existing tools.

It's a mistake not to fix this tool.  I'll post the cost in terms of bytes
wasted shortly, pretty tough to argue with that, right?

> It's a wart, but not compelling 
> enough of one to rewrite the tools from scratch.

Why would you rewrite from scratch?

> (I would also change 
> the EOA marker from "TRAILER!!!" to "" since a null filename would not 
> interfere with the namespace.)

Yes!

> I don't think think this application alone is enough to add Yet Another 
> Version of CPIO.  However, if there are more compelling reasons to do so 
>   for CPIO backup reasons itself I guess we could write it up and add it 
> to GNU cpio as "linux" format...

Oh, it is, really it is.  It's not just any application, and GNU already
has its own verion of cpio.

--
Daniel
