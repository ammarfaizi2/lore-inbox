Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTKOM3w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 07:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTKOM3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 07:29:52 -0500
Received: from csl2.consultronics.on.ca ([204.138.93.2]:48022 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S261686AbTKOM3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 07:29:50 -0500
Date: Sat, 15 Nov 2003 07:29:48 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre8-pac1 and -rc1-pac1 NFSv3 problem
Message-ID: <20031115122948.GA1330@athame.dynamicro.on.ca>
Mail-Followup-To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20031111182647.GA25026@athame.dynamicro.on.ca> <20031111190000.GA25290@athame.dynamicro.on.ca> <20031114234627.GA12679@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031114234627.GA12679@werewolf.able.es>
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20031115 (Sat) at 0046:27 +0100, J.A. Magallon wrote:
> 
> On 11.11, Greg Louis wrote:
> > On 20031111 (Tue) at 1326:47 -0500, Greg Louis wrote:
> > > Kernels 2.4.23-pre7-pac1 and 2.4.23-rc1 are ok but -pre8-pac1 and
> > > -rc1-pac1 behave as follows: mounting a remote directory via NFS with
> > > v3 enabled (client and server) seems to work ok, and running mount with
> > > no parameters shows the NFS mount, but any attempt at access fails with
> > > a message like
> > >   /bin/ls: reading directory /whatever/it/was: Input/output error
> > 
> > Reverting all changes to fs/nfs/* since 2.4.23-pre7-pac1, and only
> > those, corrects the problem.

> /metoo
> 
> It works for some time, and then it breaks.
> Could you send me the patch you used to revert those changes ?
> I will try to make a diff from rc1 to pre7 and reverse.

Actually all I did was
rm fs/nfs/*.c
cp ../linux-2.4.23pre7/fs/nfs/*.c fs/nfs

Could well be overkill but it seems to work fine on a farm of mixed
2.4.22 and 2.4.23rc1-with-this-change machines.

-- 
| G r e g  L o u i s         | gpg public key: 0x400B1AA86D9E3E64 |
|  http://www.bgl.nu/~glouis |   (on my website or any keyserver) |
|  http://wecanstopspam.org in signatures helps fight junk email. |
