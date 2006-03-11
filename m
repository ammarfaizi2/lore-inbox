Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752060AbWCKHun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbWCKHun (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 02:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbWCKHun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 02:50:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:21160 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752060AbWCKHum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 02:50:42 -0500
X-Authenticated: #14349625
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
In-Reply-To: <200603111824.06274.kernel@kolivas.org>
References: <200603102054.20077.kernel@kolivas.org>
	 <200603111650.23727.kernel@kolivas.org> <1142056851.7819.54.camel@homer>
	 <200603111824.06274.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 08:51:39 +0100
Message-Id: <1142063500.7605.13.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 18:24 +1100, Con Kolivas wrote:
> On Saturday 11 March 2006 17:00, Mike Galbraith wrote:

> > If you're creating a lot of traffic, I can see it causing problems.  I
> > was under the impression that you were doing minimal IO and absolutely
> > trivial CPU.  That's what didn't make sense to me to be clear.
> 
> A lot of cpu would be easier to handle; it's using absolutely miniscule 
> amounts of cpu. The IO is massive though (and seeky in nature), and reading 
> from a swap partition seems particularly expensive in this regard.

There used to be a pages in flight 'restrictor plate' in there that
would have probably helped this situation at least a little.  But in any
case, it sounds like you'll have to find a way to submit the IO in itty
bitty synchronous pieces.

	-Mike

