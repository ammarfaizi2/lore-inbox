Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVF1ASO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVF1ASO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVF1ASO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:18:14 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:33221 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262147AbVF1ASB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:18:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OCTKZJo3qYgdBewk1joHcSBPW+VrGgcl42kuoYTzqv2rLlxwi/mFnKM+p61y0H0Tbk+0AGcLSzn+dev/GnyrfP+NdKHo9dR+RDmPcMrbtryrNhWG4x2fYdQYdtrmjfGTBFJVTwc/8uVOi1DOYSrtLaBNdYe2MnUygZxUIkjLHFo=
Message-ID: <5c49b0ed050627171724e7de27@mail.gmail.com>
Date: Mon, 27 Jun 2005 17:17:58 -0700
From: Nate Diller <nate.diller@gmail.com>
Reply-To: Nate Diller <nate.diller@gmail.com>
To: ritesh@cs.unc.edu
Subject: Re: Documentation about the Virtual File-System
Cc: Pekka Enberg <penberg@gmail.com>,
       =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <fc67f8b705062715424a8f9759@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4fec73ca05062710082e273097@mail.gmail.com>
	 <84144f0205062710582ca366c0@mail.gmail.com>
	 <fc67f8b705062715424a8f9759@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try reading the code to Minix FS, it is simple and will demonstrate
the interfaces you need to present to VFS, and the block interface to
access the disk.  The page interface is preferred over the block
interface recently, expecially for high performance work, but FS's
that use it are more complex and harder to understand (reiserfs, xfs,
ext3).

Get Robert Love's kernel programming book, it has just barely enough
VFS documentation to get you started learning the current interfaces.

NATE


On 6/27/05, Ritesh Kumar <digitalove@gmail.com> wrote:
> On 6/27/05, Pekka Enberg <penberg@gmail.com> wrote:
> > Hi,
> > 
> > On 6/27/05, Guillermo López Alejos <glalejos@gmail.com> wrote:
> > > Is there any "Building a File system HOWTO"?
> > 
> > I am not aware of such document but take a look at fs/ramfs/inode.c.
> > It is a simple memory-based filesystem and sort of a tutorial to the
> > VFS.
> > 
> >                                Pekka
> > -
> 
> Did you try http://lxr.linux.no/source/Documentation/filesystems/vfs.txt
> 
> BTW, on a similar note can somebody recommend some simple sample code
> on block IO?
> 
> Ritesh
> 
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> -- 
> http://www.cs.unc.edu/~ritesh/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
