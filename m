Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264766AbUEaUNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbUEaUNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 16:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUEaUNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 16:13:10 -0400
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:55975 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S264766AbUEaUNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 16:13:08 -0400
Date: Mon, 31 May 2004 14:12:53 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
Message-ID: <20040531141253.A18246@mail.harddata.com>
References: <200405310250.i4V2ork05673@mailout.despammed.com> <Pine.LNX.4.58.0405311340450.4198@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0405311340450.4198@wombat.indigo.net.au>; from raven@themaw.net on Mon, May 31, 2004 at 01:44:40PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 01:44:40PM +0800, Ian Kent wrote:
> 
> Why not scaled longs (or bigger), scalled to number of significant 
> digits. The Taylor series for the trig functions might be a painfull.

Taylor series usually are painful for anything you want to calculate
by any practical means.  Slow convergence but, for a change, quickly
growing roundup errors and things like that.  An importance and uses
of Taylor series lie elsewhere.

OTOH polynomial approximations, or rational ones (after all division
is quite quick on modern processors), can be fast and surprisingly
precise; especially if you know bounds for your arguments and that
that range is not too wide.  Of course when doing that in a fixed
point one needs to pay attention to possible overflows and
structuring calculations to guard against a loss of precision is
always a good idea.

My guess is that finding some fixed-point libraries, at least to use
as a starting point, should be not too hard.

  Michal
