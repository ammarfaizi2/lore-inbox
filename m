Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSHRSGf>; Sun, 18 Aug 2002 14:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSHRSGf>; Sun, 18 Aug 2002 14:06:35 -0400
Received: from mail13.speakeasy.net ([216.254.0.213]:57287 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S315485AbSHRSGe>; Sun, 18 Aug 2002 14:06:34 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1029662182.2970.23.camel@psuedomode>
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu> 
	<1029662182.2970.23.camel@psuedomode>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 14:10:34 -0400
Message-Id: <1029694235.520.9.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears i'm completely unable to not use devfs.  Attempting to run
the kernel without mounting devfs results in it still being mounted or
if not compiled in, locks up during boot.  Attempts to run the kernel
and mv /dev does not work, umounting /dev does not work and rm'ing /dev
does not work.  I cant create the non-devfs  nodes while devfs is
mounted and i cant boot the kernel without devfs.  It seems that no
uninstall procedure has been made and i've read the documentation that
comes with the kernel about devfs and it says nothing about how to move
back to the old device nodes from devfs.  

anyone have any suggestions?




On Sun, 2002-08-18 at 05:16, Ed Sweetman wrote:
> On Sun, 2002-08-18 at 05:10, Alexander Viro wrote:
> > 
> > 
> > On 18 Aug 2002, Ed Sweetman wrote:
> > 
> > > (overview written in hindsight of writing email)  
> > > I ran all these tests on ide/host2/bus0/target0/lun0/part1 
> > 
> > Don't be silly - if you want to test anything, devfs is the last thing
> > you want on the system.
> > 
> > 
> 
> 
> OK, i can remove devfs, but I dont really see how that would make dma
> transfers (memory) become corrupted and pio mode transfers (memory) to
> not.  
> 
> I'm going to remove it, but i dont see how it's going to affect what's
> going on. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


