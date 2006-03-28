Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWC1JKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWC1JKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 04:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWC1JKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 04:10:50 -0500
Received: from mail.gmx.de ([213.165.64.20]:25011 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751387AbWC1JKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 04:10:49 -0500
X-Authenticated: #14349625
Subject: Re: scheduler starvation resistance patches for 2.6.16
From: Mike Galbraith <efault@gmx.de>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143522632.7441.16.camel@homer>
References: <200603272136.07908.a1426z@gawab.com>
	 <1143522632.7441.16.camel@homer>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 11:12:00 +0200
Message-Id: <1143537120.10571.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 07:10 +0200, Mike Galbraith wrote:
> On Mon, 2006-03-27 at 21:36 +0300, Al Boldi wrote:
> > It's not bad.  w/ credit_c1/2 set to 0 results in an improvement in running 
> > the MESA demos  "# gears & reflect & morph3d" .
> 
> Hmm.  That's unexpected.
> 
> > But a simple "# while :; do :; done &" (10x) makes a "# ping 10.1 -A -s8" 
> > choke.
> 
> Ouch, so is that.  But thanks, testcases are great.  I'll look into it.

OK, this has nothing to do with my patches.  The same slowdown happens
with a stock kernel when running a few pure cpu hogs.  I suspect it has
to do with softirqd, but am still investigating.

	-Mike

