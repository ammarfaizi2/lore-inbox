Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWFOKU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWFOKU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 06:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWFOKU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 06:20:59 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:10039 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S932460AbWFOKU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 06:20:58 -0400
Subject: Re: [RFC][PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4490310C.9010601@linux.intel.com>
References: <1150297122.31522.54.camel@lappy>
	 <4490310C.9010601@linux.intel.com>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 12:20:52 +0200
Message-Id: <1150366852.22475.19.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 08:53 -0700, Arjan van de Ven wrote:
> Peter Zijlstra wrote:
> > From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > Some folks find 128KB of env+arg space too little. Solaris provides them with
> > 1MB. Manually changing MAX_ARG_PAGES worked for them so far, however they
> > would like to run the supported vendor kernel.
> 
> then this patch should go to the vendors maybe ;)

You know it comes from one :-)

But as Randy said, there is interrest to not deviate too much and esp.
wrt. interfaces.

> > 
> > In the interrest of not penalizing everybody with the overhead of just
> > setting it larger, provide a sysctl to change it.
> > 
> 
> why not go all the way and make it truely dynamic ?

Looking at the code again even this change feels heavy, making it
dynamic would only bloat it more.

If you really think we'll gain anything by having this dynamic please
tell me and I'll make an honest effort, but for now I'd like to stick
with this approach.

Peter

