Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVCUTFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVCUTFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVCUTFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:05:16 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:57590 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S261591AbVCUTFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:05:10 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] NMI handler message passing / work deferral API
Date: Mon, 21 Mar 2005 11:03:56 -0800
User-Agent: KMail/1.5.3
Cc: oprofile-list@lists.sourceforge.net, bluesmoke-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, dave_peterson@pobox.com
References: <200503202056.02429.dave_peterson@pobox.com> <m1eke93ul3.fsf@muc.de>
In-Reply-To: <m1eke93ul3.fsf@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503211103.56930.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 07:08 am, Andi Kleen wrote:
> Dave Peterson <dave_peterson@pobox.com> writes:
> > Below is an experimental 2.6.11.5 kernel patch that implements the
> > following:
> >
> >      - A generic mechanism for safely passing information from NMI
> > handlers to code that executes outside NMI context.
>
> See the machine check queueing implementation in
> arch/x86_64/kernel/mce.c. It does exactly that already.
>
> Several other architectures already have similar mechanisms.
>
> -Andi

Yes exactly.  That's one reason why I posted the patch.  Different
sybsystems that need this type of functionality shouldn't have to
individually reinvent the wheel.  With a single implementation, code
is more compact and easier to understand and maintain.  I would argue
that code maintenance is of particular concern to code such as NMI
and machine check handlers because bugs in this type of code can be
hard to track down.

Dave
