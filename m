Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271391AbTHHPQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271399AbTHHPQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:16:09 -0400
Received: from [212.18.235.100] ([212.18.235.100]:19110 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S271391AbTHHPQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:16:05 -0400
Subject: Re: Innovision EIO DM-8301H/R SATA cards...
From: Justin Cormack <justin@street-vision.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Watts <m.watts@eris.qinetiq.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F33B3B9.7030905@pobox.com>
References: <200308081408.16564.m.watts@eris.qinetiq.com>
	<3F33A3EB.9030108@pobox.com> <200308081511.28238.m.watts@eris.qinetiq.com> 
	<3F33B3B9.7030905@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 08 Aug 2003 16:16:12 +0100
Message-Id: <1060355773.28644.8.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-08 at 15:29, Jeff Garzik wrote:
> Mark Watts wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > 
> > 
> >>Mark Watts wrote:
> >>
> >>>-----BEGIN PGP SIGNED MESSAGE-----
> >>>Hash: SHA1
> >>>
> >>>
> >>>My local supplier has started doing some SATA cards....
> >>>
> >>>http://www.ivmm.com/eio/products_sata_pci_host.html
> >>>
> >>>
> >>>The chip on the board i the screenshot looks vaguely like a Silicon Image
> >>>chip - - am I correct in thinking that these are supported in linux?
> >>
> >>If they are Silicon Image, yes, they are supported.
> > 
> > 
> > Great stuff - can someone confirm whether I still need to do the folloing for 
> > the latest 2.4.22 kernels in order to get good performance?
> > 
> > # hdparm -d1 -X66 /dev/hdX
> > # echo "max_kb_per_request:15" > /proc/.ide/hdX/settings
> 
> 
> I have no idea :(   I'm off in libata land, which will soon support 
> Silicon Image SATA as well...

the answer is yes - there hasnt been an update to the driver. Andre
Hedrick says he has fixed it a month or so ago but has not released it
yet.

btw echo "max_kb_per_request:15" > /proc/.ide/hdX/settings is not for
good performance (it may halve your performance on some drives) it is a
bug workaround.

Look forward to testing libata on Silicon Image.

Justin


