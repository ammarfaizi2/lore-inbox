Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWJaJiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWJaJiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422766AbWJaJiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:38:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38031 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422795AbWJaJiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:38:09 -0500
Subject: Re: [PATCH 2.6.19-rc3] i386/io_apic: fix compiler warning in
	create_irq
From: Ingo Molnar <mingo@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061030170445.1dedce1e.akpm@osdl.org>
References: <tkrat.b1c929dd899e625a@s5r6.in-berlin.de>
	 <20061030090231.GA27146@elte.hu>  <20061030170445.1dedce1e.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 10:37:37 +0100
Message-Id: <1162287457.15286.186.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 17:04 -0800, Andrew Morton wrote:
> > >     irq = -ENOSPC;
> > > +   vector = 0;
> > 
> > NAK - the code is fine, and this is fixed in Jeff's gcc-warnings
> tree 
> > via annotation.
> 
> err, what gcc-warnings tree?
> 
> git
> +ssh://master.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git#gccbug
> just does lots of initialise-to-zero thingies, doesn't have any
> special
> annotation and doesn't fix io_apic.c.

this is an initialize-to-zero annotation for a false-positive gcc
warning. If it's not in Jeff tree yet then it should be there ...

	Ingo

