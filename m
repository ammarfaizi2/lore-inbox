Return-Path: <linux-kernel-owner+w=401wt.eu-S1750786AbXAIA02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbXAIA02 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXAIA02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:26:28 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:39183 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbXAIA01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:26:27 -0500
X-Originating-Ip: 74.109.71.198
Date: Mon, 8 Jan 2007 19:21:14 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Paul Mackerras <paulus@samba.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up PPC code to use canonical alignment macros from
 kernel.h.
In-Reply-To: <17826.46886.680834.928790@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0701081920320.3589@localhost.localdomain>
References: <Pine.LNX.4.64.0701081535140.2965@localhost.localdomain>
 <17826.46886.680834.928790@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007, Paul Mackerras wrote:

> Robert P. J. Day writes:
>
> >   Clean up some PowerPC source files to use the canonical alignment
> > macros from kernel.h, and add an ALIGN_DOWN() macro to kernel.h for
> > symmetry.
>
> [snip]
>
> >   and, no, i didn't test-compile this as i don't have a PPC
> > cross-compiler at the moment.  sorry.
>
> Yeah.  I would be surprised if it did build, since you are removing
> definitions without adding any #includes to make sure we get the
> global definition.
>
> >  arch/powerpc/boot/addRamDisk.c               |    3 +--
> >  arch/powerpc/boot/of.c                       |    2 +-
> >  arch/powerpc/boot/page.h                     |    9 +--------
> >  arch/powerpc/boot/simple_alloc.c             |    8 ++++----
>
> NAK.  Stuff in arch/powerpc/boot intentionally *doesn't* depend on
> Linux kernel headers, since it runs outside of the kernel, either on
> the build machine (addRamDisk.c) or before the kernel.

whoops, sorry, i totally missed that.  my apologies.

rday
