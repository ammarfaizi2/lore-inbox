Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270813AbRHNU1x>; Tue, 14 Aug 2001 16:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270812AbRHNU1n>; Tue, 14 Aug 2001 16:27:43 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:36579 "EHLO
	inet-mail3.oraclecorp.com") by vger.kernel.org with ESMTP
	id <S270808AbRHNU1c>; Tue, 14 Aug 2001 16:27:32 -0400
Message-ID: <3B798A3C.F59680B0@oracle.com>
Date: Tue, 14 Aug 2001 22:29:48 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-pre2 breaks UFS as a module
In-Reply-To: <E15WPsE-0008MG-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > make[2]: Entering directory `/share/src/linux-2.4.9-pre2/fs/ufs'
> > gcc -D__KERNEL__ -I/share/src/linux-2.4.9-pre2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
> > -DMODULE   -c -o file.o file.c
> > file.c:80: `generic_file_open' undeclared here (not in a function)
> > file.c:80: initializer element is not constant
> > file.c:80: (near initialization for `ufs_file_operations.open')
> > make[2]: *** [file.o] Error 1
> > make[2]: Leaving directory `/share/src/linux-2.4.9-pre2/fs/ufs'
> > make[1]: *** [_modsubdir_ufs] Error 2
> > make[1]: Leaving directory `/share/src/linux-2.4.9-pre2/fs'
> > make: *** [_mod_fs] Error 2
> 
> I'll take a look at that, Im trying to merge VFS things with Linus and its
> non trivial to get all the bits in place and in the right order 8(

I can confirm it builds okay in -pre3, thanks ! I've used it only
 once as Digital Unix support folks provided a small patch on a
 floppy to a customer, then said customer noticed Windows could not
 recognize the contents - it was an UFS formatted floppy...

--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
