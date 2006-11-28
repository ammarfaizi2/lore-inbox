Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936091AbWK1UOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936091AbWK1UOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936095AbWK1UOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:14:48 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:46862 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S936091AbWK1UOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:14:47 -0500
Subject: Re: [PATCH 2/2 -mm] fault-injection: lightweight code-coverage
	maximizer
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20061128091811.GA2004@APFDCB5C>
References: <1164699866.2894.88.camel@localhost.localdomain>
	 <1164700290.2894.93.camel@localhost.localdomain>
	 <20061128091811.GA2004@APFDCB5C>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 12:14:36 -0800
Message-Id: <1164744877.2894.133.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 18:18 +0900, Akinobu Mita wrote:
> On Mon, Nov 27, 2006 at 11:51:30PM -0800, Don Mullis wrote:
> > Upon keying in
> > 	echo 1 >probability
> > 	echo 3 >verbose
> > 	echo -1 >times
> > a few dozen stacks are printk'ed, then system responsiveness
> > recovers to normal.  Similarly, starting a non-trivial program
> > will print a few stacks before responsiveness recovers.
> 
> What kind of test did you do?

First, waiting a few seconds for the standard FC-6 daemons to wake up.
Then, Xemacs and Firefox.  Not tested on SMP.


> This doesn't maximize code coverage. It makes fault-injector reject
> any failures which have same stacktrace before.

Since the volume of (repeated) dumps is greatly reduced, 
interval/probability can be set more aggressively without crippling
interaction.  This increases the number of error recovery paths covered
per unit of wall clock time.


> Updating array in this way is not safe (SMP or interrupt).
 
You're right.  Patch forthcoming.

