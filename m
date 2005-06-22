Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbVFVI4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVFVI4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVFVIyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:54:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60338 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262781AbVFVIuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:50:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH 10/11] ppc64: SPU file system
Date: Wed, 22 Jun 2005 10:47:13 +0200
User-Agent: KMail/1.7.2
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <200506212310.54156.arnd@arndb.de> <200506212334.44066.arnd@arndb.de> <dc0a828aec834a05b3b3fd6d4f6e3426@penguinppc.org>
In-Reply-To: <dc0a828aec834a05b3b3fd6d4f6e3426@penguinppc.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506221047.14602.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 22 Juni 2005 02:21, Hollis Blanchard wrote:
> On Jun 21, 2005, at 4:34 PM, Arnd Bergmann wrote:
> 
> > +union MFC_TagSizeClassCmd {
> 
> I think great effort has gone in to removing so-called "StudlyCaps" 
> from the ppc64 iSeries code... :)

Yes. I've been wanting to fix this one for ages, but it keeps
slipping through. The file used to be shared with user space
(bad idea) and the CPU simulator and I tried to at least keep
the structure definitions compatible initially.

> Also, I didn't see "MFC" defined anywhere... it's sort of a pet peeve, 
> but could you make sure all your acronyms are defined? Most of them are 
> described in spu.h, but a few slipped through I think (like "SMF").

good point

> And while a comment at the top of every file is great, ones like this:
> > +/*
> > + * Low-level SPU handling
> > + *
> might be more helpful if they defined SPU and further mentioned it's 
> the coprocessor in the Broadband Processor Architecture...

Yes, all this is the sort of stuff you never notice unless you take
while working on a piece of code for months.

Thanks,

	Arnd <><
