Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbTCFXIk>; Thu, 6 Mar 2003 18:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbTCFXIj>; Thu, 6 Mar 2003 18:08:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34309 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261211AbTCFXIf>; Thu, 6 Mar 2003 18:08:35 -0500
Date: Thu, 6 Mar 2003 23:19:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
Message-ID: <20030306231905.M838@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com> <1046990052.18158.121.camel@irongate.swansea.linux.org.uk> <20030306221136.GB26732@gtf.org> <20030306222546.K838@flint.arm.linux.org.uk> <1046996037.18158.142.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046996037.18158.142.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 07, 2003 at 12:13:57AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 12:13:57AM +0000, Alan Cox wrote:
> On Thu, 2003-03-06 at 22:25, Russell King wrote:
> > > > The right fix is to delete ipconfig.c, it has been the right fix for a long
> > > > long time. There are initrd based bootp/dhcp setups that can also then mount
> > > > a root NFS partition and they do *not* need any kernel helper.
> > > 
> > > The klibc tarball on kernel.org also has ipconfig-type code, waiting for
> > > initramfs early userspace :)
> > > 
> > > Many have wanted to delete ipconfig.c for a while now...
> > 
> > Yep, can't the deletion wait a couple more weeks or so until klibc gets
> > merged?  It's not like ipconfig.c is broken currently, is it?
> 
> Thats how it ended up in 2.4. Klibc doesnt really matter, the apps exist
> linked with dietlibc and stuff even without klibc.
> 
> Time for it to die

"klibc doesnt really matter"

I'd prefer not to have to have thousands of special programs around
just to be able to boot my machines, especially when it was all in-
kernel up until this point.

klibc yes, dietlibc with random other garbage in some random filesystem
which'd need maintaining - no thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

