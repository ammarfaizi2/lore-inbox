Return-Path: <linux-kernel-owner+w=401wt.eu-S932275AbWLLRcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWLLRcz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWLLRcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:32:55 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43361 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932275AbWLLRcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:32:54 -0500
Date: Tue, 12 Dec 2006 17:40:55 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: Make OLPC camera driver depend on x86.
Message-ID: <20061212174055.6b60c134@localhost.localdomain>
In-Reply-To: <20061212153956.GH8509@redhat.com>
References: <20061212145258.GA29952@redhat.com>
	<12591.1165936372@lwn.net>
	<20061212153956.GH8509@redhat.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 10:39:56 -0500
Dave Jones <davej@redhat.com> wrote:

> On Tue, Dec 12, 2006 at 08:12:52AM -0700, Jonathan Corbet wrote:
>  > Dave Jones <davej@redhat.com> wrote:
>  > 
>  > > -	depends on I2C && VIDEO_V4L2
>  > > +	depends on I2C && VIDEO_V4L2 && X86_32
>  > 
>  > Any particular reason why?
> 
> Just seemed odd to be offered the option when I was building
> an ia64 kernel given its extremely unlikely to ever appear there.

It means we catch portability bugs early and people changing core code
catch problems even if their platform is not X86_32. The practice for
almost all out drivers is thus not to put in arch dependancies unless
they genuinely do not build on arbitary platforms.

NAK
