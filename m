Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVBJTOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVBJTOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVBJTNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:13:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53444 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261423AbVBJTKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:10:23 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Patrick Gefre <pfg@sgi.com>
Subject: Re: [PATCH] Altix : ioc4 serial driver support
Date: Thu, 10 Feb 2005 11:09:43 -0800
User-Agent: KMail/1.7.2
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       matthew@wil.cx, B.Zolnierkiewicz@elka.pw.edu.pl
References: <20050103140938.GA20070@infradead.org> <20050207162525.GA15926@infradead.org> <4208EE3A.6010500@sgi.com>
In-Reply-To: <4208EE3A.6010500@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101109.43455.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 8, 2005 8:52 am, Patrick Gefre wrote:
> I've update the patch with changes from the comments below.
>
> ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support
>
> Christoph Hellwig wrote:
> > On Mon, Feb 07, 2005 at 09:58:33AM -0600, Patrick Gefre wrote:
> >>Latest version with review mods:
> >>ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support
> >
> >  - still not __iomem annotations.
>
> I *think* I have this right ??

Here's the output from 'make C=1' with your driver patched in (you if you want
to run it yourself, just copy tomahawk.engr:~jbarnes/bin/sparse to somewhere
in your path and run 'make C=1').  I think most of these warning would be
fixed up if the structure fields referring to registers were declared as
__iomem, but I haven't looked carefully.

Jesse

  CHECK   drivers/serial/ioc4_serial.c
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:796:11: warning: incorrect type in argument 1 (different address spaces)
drivers/serial/ioc4_serial.c:796:11:    expected void const volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:796:11:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:796:11: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:796:11:    expected void const volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:796:11:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:800:11: warning: incorrect type in argument 1 (different address spaces)
drivers/serial/ioc4_serial.c:800:11:    expected void const volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:800:11:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:800:11: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:800:11:    expected void const volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:800:11:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:2722:6: warning: incorrect type in assignment (different address spaces)
drivers/serial/ioc4_serial.c:2722:6:    expected struct ioc4_mem *mem
drivers/serial/ioc4_serial.c:2722:6:    got void [noderef] *<asn:2>
drivers/serial/ioc4_serial.c:2742:9: warning: incorrect type in assignment (different address spaces)
drivers/serial/ioc4_serial.c:2742:9:    expected struct ioc4_serial *serial
drivers/serial/ioc4_serial.c:2742:9:    got void [noderef] *<asn:2>
drivers/serial/ioc4_serial.c:2786:2: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:2786:2:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:2786:2:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:2786:2: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:2786:2:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:2786:2:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:2789:2: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:2789:2:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:2789:2:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:2789:2: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:2789:2:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:2789:2:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:2795:2: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:2795:2:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:2795:2:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:2795:2: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:2795:2:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:2795:2:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:693:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:693:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:693:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:697:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:697:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:697:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:2798:2: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:2798:2:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:2798:2:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:2798:2: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:2798:2:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:2798:2:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:1106:16: warning: incorrect type in assignment (different address spaces)
drivers/serial/ioc4_serial.c:1106:16:    expected struct ioc4_mem [noderef] *ip_mem<asn:2>
drivers/serial/ioc4_serial.c:1106:16:    got struct ioc4_mem *<noident>
drivers/serial/ioc4_serial.c:1107:19: warning: incorrect type in assignment (different address spaces)
drivers/serial/ioc4_serial.c:1107:19:    expected struct ioc4_serial [noderef] *ip_serial<asn:2>
drivers/serial/ioc4_serial.c:1107:19:    got struct ioc4_serial *<noident>
drivers/serial/ioc4_serial.c:875:11: warning: incorrect type in assignment (different address spaces)
drivers/serial/ioc4_serial.c:875:11:    expected unsigned int [usertype] *sbbr_l
drivers/serial/ioc4_serial.c:875:11:    got unsigned int [unsigned] [noderef] [usertype] *<noident><asn:2>
drivers/serial/ioc4_serial.c:876:11: warning: incorrect type in assignment (different address spaces)
drivers/serial/ioc4_serial.c:876:11:    expected unsigned int [usertype] *sbbr_h
drivers/serial/ioc4_serial.c:876:11:    got unsigned int [unsigned] [noderef] [usertype] *<noident><asn:2>
drivers/serial/ioc4_serial.c:878:11: warning: incorrect type in assignment (different address spaces)
drivers/serial/ioc4_serial.c:878:11:    expected unsigned int [usertype] *sbbr_l
drivers/serial/ioc4_serial.c:878:11:    got unsigned int [unsigned] [noderef] [usertype] *<noident><asn:2>
drivers/serial/ioc4_serial.c:879:11: warning: incorrect type in assignment (different address spaces)
drivers/serial/ioc4_serial.c:879:11:    expected unsigned int [usertype] *sbbr_h
drivers/serial/ioc4_serial.c:879:11:    got unsigned int [unsigned] [noderef] [usertype] *<noident><asn:2>
drivers/serial/ioc4_serial.c:886:3: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:886:3:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:886:3:    got unsigned int [usertype] *sbbr_h
drivers/serial/ioc4_serial.c:886:3: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:886:3:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:886:3:    got unsigned int [usertype] *sbbr_h
drivers/serial/ioc4_serial.c:887:3: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:887:3:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:887:3:    got unsigned int [usertype] *sbbr_l
drivers/serial/ioc4_serial.c:887:3: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:887:3:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:887:3:    got unsigned int [usertype] *sbbr_l
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:681:4: warning: incorrect type in initializer (different address spaces)
drivers/serial/ioc4_serial.c:681:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:681:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: incorrect type in argument 2 (different address spaces)
drivers/serial/ioc4_serial.c:685:4:    expected void volatile [noderef] *addr<asn:2>
drivers/serial/ioc4_serial.c:685:4:    got unsigned int [unsigned] [usertype] *<noident>
drivers/serial/ioc4_serial.c:685:4: warning: too many warnings
