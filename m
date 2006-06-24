Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWFXEpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWFXEpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 00:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWFXEpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 00:45:09 -0400
Received: from loopy.telegraphics.com.au ([202.45.126.152]:52939 "EHLO
	loopy.telegraphics.com.au") by vger.kernel.org with ESMTP
	id S932173AbWFXEpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 00:45:07 -0400
Date: Sat, 24 Jun 2006 14:45:06 +1000 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH 08/21] gcc 4 fix
In-Reply-To: <Pine.LNX.4.64.0606232158400.17704@scrub.home>
Message-ID: <Pine.LNX.4.64.0606241420330.1073@loopy.telegraphics.com.au>
References: <20060623183056.479024000@linux-m68k.org> <20060623183911.847605000@linux-m68k.org>
 <20060623193524.GA27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606232158400.17704@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jun 2006, Roman Zippel wrote:

> Hi,
> 
> On Fri, 23 Jun 2006, Al Viro wrote:
> 
> > On Fri, Jun 23, 2006 at 08:31:04PM +0200, zippel@linux-m68k.org wrote:
> > > Fixes a "static qualifier follows non-static qualifier" error from 
> > > gcc 4.
> > > 
> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au> 
> > > Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> > 
> > Broken.  Proper fix is to rename the function so that it wouldn't 
> > clash.
> 
> Well, I wouldn't call it broken, as both versions can never be compiled 
> into the same kernel, but I don't care much how it's fixed.
> 
> Does anyone know the relationship between via-pmu.c and via-pmu68k.c? If 
> it's intended to keep the differences small, a rename would be the wrong 
> fix.

The relationship is (and was) just that they share the pmu.h header file 
declarations. In the patch in question I used the powerpc definition as 
well.

The powerpc version exports pmu_queue_request (apparently for the use of 
low_i2c.c). The m68k version doesn't, but if it needed to export it, I 
don't see why it shouldn't implement the same "API"?

-f

> bye, Roman
> 
