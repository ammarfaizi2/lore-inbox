Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315910AbSFESn5>; Wed, 5 Jun 2002 14:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSFESn4>; Wed, 5 Jun 2002 14:43:56 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:34571 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315910AbSFESny>;
	Wed, 5 Jun 2002 14:43:54 -0400
Date: Wed, 5 Jun 2002 11:41:10 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Keith Owens <kaos@ocs.com.au>, Johannes Erdfelt <johannes@erdfelt.com>,
        Joseph Pingenot <trelane@digitasaru.net>, linux-kernel@vger.kernel.org
Subject: Re: Build error on 2.5.20 under unstable debian
Message-ID: <20020605184110.GA3731@kroah.com>
In-Reply-To: <23055.1023262706@kao2.melbourne.sgi.com> <Pine.NEB.4.44.0206050958190.9994-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 08 May 2002 17:05:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 10:18:52AM +0200, Adrian Bunk wrote:
> On Wed, 5 Jun 2002, Keith Owens wrote:
> 
> >...
> > R_386_32 is an ELF relocation type for ix86 binaries.  It means that
> > uhci-hcd.c has code that refers to a function defined as __exit.  The
> > only such function is uhci_hcd_cleanup but I cannot see where it is
> > being referenced.  The USB people should be able to track this one
> > down.
> 
> uhci_stop is __devexit but the pointer to it doesn't use __devexit_p.
> The fix is simple:

Applied to my tree, thanks.  I'll send to to Linus in a bit.

greg k-h
