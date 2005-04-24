Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVDXKSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVDXKSi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 06:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVDXKSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 06:18:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262304AbVDXKSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 06:18:31 -0400
Date: Sun, 24 Apr 2005 03:14:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport insert_resource
Message-Id: <20050424031447.45bb6b60.akpm@osdl.org>
In-Reply-To: <20050424095223.GA22146@infradead.org>
References: <20050415151043.GJ5456@stusta.de>
	<20050423164411.51d77bf1.akpm@osdl.org>
	<20050424095223.GA22146@infradead.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Apr 23, 2005 at 04:44:11PM -0700, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > I didn't find any possible modular usage in the kernel.
> > > 
> > 
> > True, but this looks like something which out-of-tree code could possibly
> > be using.  I'd prefer to see this one get the deprecated_for_modules
> > twelve-month treatment.
> 
> Don't you think twelve month is damn long?  Two kernel releases seem
> like a better policy - extremly long deprecation periods only encourage
> people to never look at mainline kernels but just ad vendor trees.

A year ago we were at 2.6.6.  It's not that long, really.

> Note that you're not really helping driver authors by exporting random
> kernel symbols

We can mark these things as deprecated-in-modules today, to avoid new usages.
