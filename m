Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S271445AbUJVQbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271445AbUJVQbR (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 22 Oct 2004 12:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271455AbUJVQbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:31:17 -0400
Received: from ee.oulu.fi ([130.231.61.23]:51633 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S271445AbUJVQbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:31:16 -0400
Date: Fri, 22 Oct 2004 19:30:17 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Onur Kucuk <onur@delipenguen.net>, Olivier Galibert <galibert@pobox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Buggy DSDTs policy ?
Message-ID: <20041022163017.GA18156@ee.oulu.fi>
References: <20041022122326.GA69381@dspnet.fr.eu.org> <20041022174154.2ebd2c5c.onur@delipenguen.net> <1098456935.31003.77.camel@gonzales> <20041022151943.GA16874@ee.oulu.fi> <1098459316.31003.93.camel@gonzales>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1098459316.31003.93.camel@gonzales>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 05:35:16PM +0200, Xavier Bestel wrote:
> > The problem is getting the fixed dsdt in use without recompiling your
> > kernel, since quite a few people, especially non-technical ones, use vendor
> > kernels. There's an approach that uses initrd, but this isn't merged
> > yet. I'd say it should be, assuming no better solution can be found.
> 
> Yes, sure. But real non-technical people won't replace their DSDT
> either.
Their distro could do it for them :-) A simple approach would be to
store md5sums of known-bad dsdt's and xdeltas to fixed ones, and the 
fixed one gets placed in /etc where mkinitrd automagically picks it up
whenever a new kernel is installed.

But that's userspace (with possible problems in distributing dsdt's, which
is why xdelta might be an acceptable solution), the kernel should just make
something like like that possible, if someone wants to do it.
