Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSDHGP1>; Mon, 8 Apr 2002 02:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313564AbSDHGP0>; Mon, 8 Apr 2002 02:15:26 -0400
Received: from zero.tech9.net ([209.61.188.187]:28940 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313563AbSDHGPZ>;
	Mon, 8 Apr 2002 02:15:25 -0400
Subject: Re: Extraversion in System.map?
From: Robert Love <rml@tech9.net>
To: Tom Holroyd <tomh@po.crl.go.jp>
Cc: marcelo@conectiva.com.br,
        kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204081502180.548-100000@holly.crl.go.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 02:15:20 -0400
Message-Id: <1018246521.1534.145.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-08 at 02:07, Tom Holroyd wrote:

> As part of my penance for using the wrong System.map file in the
> readprofile data I sent out, I have prepared a patch to readprofile
> that makes it check the version of the file against the kernel.
> 
> Much to my dismay, the extraversion code ('-pre6' for example) does
> not appear to be anywhere in System.map.  Or am I wrong?  If not, why
> not, and can this be fixed?  After all, symbols can and do change
> between -pre versions.

Eh, no kernel version is associated with System.map.  It has no embedded
information, what-so-ever, aside from the symbols.

Do what everyone else does and name your System.map appropriately, i.e.
System.map-2.5.8-pre2 and then on boot symlink System.map to
System.map-`uname -r`.  Most (all?) distributions do this for you
already.

You can also pass readprofile the -m flag to specify the map file to
use.  A little script that does "readprofile -m System.map-`uname -r`"
would work fine.

	Robert Love

