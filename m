Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWHBDKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWHBDKi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWHBDKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:10:38 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38793 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751093AbWHBDKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:10:37 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
Date: Wed, 2 Aug 2006 05:10:07 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <p73zmeoz2l4.fsf@verdi.suse.de> <m1ejvzx2dw.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ejvzx2dw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020510.07569.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > /* WARNING!!
> >  * This code is compiled with -fPIC and it is relocated dynamically
> >  * at run time, but no relocation processing is performed.
> >  * This means that it is not safe to place pointers in static structures.
> >  */

iirc the only static relocation in early_printk is the one to initialize
the console pointers - that could certainly be moved to be at run time.
 
> lib/string.c might be useful.  The fact that the functions are not
> static slightly concerns me.  I have a vague memory of non-static
> functions generating relocations for no good reason.

Would surprise me.

-Andi
