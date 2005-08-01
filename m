Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVHAUG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVHAUG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVHAUEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:04:30 -0400
Received: from tim.rpsys.net ([194.106.48.114]:45528 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261211AbVHAUCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:02:36 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0508010908530.3546@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 21:02:16 +0100
Message-Id: <1122926537.7648.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 09:10 -0700, Christoph Lameter wrote:
> On Mon, 1 Aug 2005, Richard Purdie wrote:
> 
> > The system appears to be ok and boots happily to a console but if you
> > load any graphical UI, the screen will blank and the process stops
> > working (tested with opie and and xserver+GPE). You can kill -9 the
> > process but you can't regain the console without a suspend/resume cycle
> > which performs enough of a reset to get it back. chvt and the console
> > switching keys don't respond.
> 
> Is this related to the size of the process? Can you do a successful kernel 
> compile w/o X?

Its an embedded device and lacks development tools to test that. I ran
some programs which abuse malloc and the process would quite happily hit
oom so it looks like something more is needed to trigger the bug...

> > I tried the patch mentioned in http://lkml.org/lkml/2005/7/28/304 but it
> > makes no difference.
> 
> Yes that only helps if compilation fails and its alread in rc4-mm1 AFAIK.

I thought that might be the case.

Richard

