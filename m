Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWFLRPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWFLRPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWFLRPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:15:54 -0400
Received: from hera.kernel.org ([140.211.167.34]:37087 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751231AbWFLRPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:15:53 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 built-in command line
Date: Mon, 12 Jun 2006 10:15:32 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6k7fk$h01$1@terminus.zytor.com>
References: <20060611215530.GH24227@waste.org> <1150069241.3131.97.camel@laptopd505.fenrus.org> <20060611235101.GK24227@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150132532 17410 127.0.0.1 (12 Jun 2006 17:15:32 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 12 Jun 2006 17:15:32 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060611235101.GK24227@waste.org>
By author:    Matt Mackall <mpm@selenic.com>
In newsgroup: linux.dev.kernel
>
> On Mon, Jun 12, 2006 at 01:40:41AM +0200, Arjan van de Ven wrote:
> > On Sun, 2006-06-11 at 16:55 -0500, Matt Mackall wrote:
> > > This patch allows building in a kernel command line on x86 as is
> > > possible on several other arches.
> > 
> > wouldn't it make more sense to allow the initramfs to set such arguments
> > instead?
> 
> Huh?
> 
> Are you suggesting we go digging around in a gzipped initramfs image at
> early command line parsing time? I can't really see how that would work. 
> 

You can append to it without unzipping it.  It's probably the wrong
thing for this, though, since there are numerous stages of kernel
initialization which don't have access to the initramfs.

	-hpa
