Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTJTVxh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTJTVxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:53:36 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:55181 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262850AbTJTVwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:52:44 -0400
Subject: Re: LVM on md0: raid0_make_request bug: can't convert block across
	chunks or bigger than 64k
From: Karl Vogel <karl.vogel@seagha.com>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200310201606.09098.kevcorry@us.ibm.com>
References: <1066682115.1799.15.camel@kvo.local.org>
	 <200310201606.09098.kevcorry@us.ibm.com>
Content-Type: text/plain
Message-Id: <1066686755.1146.6.camel@kvo.local.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Mon, 20 Oct 2003 23:52:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-20 at 23:06, Kevin Corry wrote:
> On Monday 20 October 2003 15:35, Karl Vogel wrote:
> > I'm getting the following kernel messages on V2.6.0-test8-mm1 (I've also
> > tried plain -test7 and some kernels before that) when copying moderately
> > sized files from a raid-0/LVM volume:
> >
> > --- snip ---
> > raid0_make_request bug: can't convert block across chunks or bigger than
> > 64k 24081064 64
> > raid0_make_request bug: can't convert block across chunks or bigger than
> > 64k 24080656 64
> > raid0_make_request bug: can't convert block across chunks or bigger than
> > 64k 24080784 64
> > raid0_make_request bug: can't convert block across chunks or bigger than
> > 64k 24080928 64
> 
> Looks like this was just recently fixed on the linux-raid list.
> 
> http://marc.theaimsgroup.com/?l=linux-raid&m=106661294929434

Applied the patch on 2.6.0-test8-mm1 but it made no difference.

Somebody else referred to this posting:
  http://marc.theaimsgroup.com/?l=linux-kernel&m=103369952814053&w=2

but that patch doesn't apply cleanly anymore and I'm not familiar with
the code to be confident to fix it up myself. (that post was from almost
exactly 1 year ago, so alot changed probably :)


