Return-Path: <linux-kernel-owner+w=401wt.eu-S932232AbWLLRmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWLLRmV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWLLRmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:42:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50367 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932232AbWLLRmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:42:19 -0500
Date: Tue, 12 Dec 2006 12:42:10 -0500
From: Dave Jones <davej@redhat.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: Make OLPC camera driver depend on x86.
Message-ID: <20061212174210.GC2140@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan <alan@lxorguk.ukuu.org.uk>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
References: <20061212145258.GA29952@redhat.com> <12591.1165936372@lwn.net> <20061212153956.GH8509@redhat.com> <20061212174055.6b60c134@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212174055.6b60c134@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 05:40:55PM +0000, Alan Cox wrote:
 > >  > > -	depends on I2C && VIDEO_V4L2
 > >  > > +	depends on I2C && VIDEO_V4L2 && X86_32
 > >  > 
 > >  > Any particular reason why?
 > > 
 > > Just seemed odd to be offered the option when I was building
 > > an ia64 kernel given its extremely unlikely to ever appear there.
 > 
 > It means we catch portability bugs early and people changing core code
 > catch problems even if their platform is not X86_32. The practice for
 > almost all out drivers is thus not to put in arch dependancies unless
 > they genuinely do not build on arbitary platforms.
 > 
 > NAK

Given this could in theory turn up in USB form one day, and some
lunatic may actually plug one into an ia64, I see your point.
Unlikely, but feasible.

		Dave

-- 
http://www.codemonkey.org.uk
