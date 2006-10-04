Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161550AbWJDQag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161550AbWJDQag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161540AbWJDQag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:30:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161557AbWJDQaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:30:35 -0400
Date: Wed, 4 Oct 2006 09:30:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: tim.c.chen@linux.intel.com
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, leonid.i.ananiev@intel.com
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Message-Id: <20061004093025.ab235eaa.akpm@osdl.org>
In-Reply-To: <1159968095.8035.76.camel@localhost.localdomain>
References: <1159916644.8035.35.camel@localhost.localdomain>
	<4522FB04.1080001@goop.org>
	<1159919263.8035.65.camel@localhost.localdomain>
	<45233B1E.3010100@goop.org>
	<1159968095.8035.76.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 06:21:35 -0700
Tim Chen <tim.c.chen@linux.intel.com> wrote:

> On Tue, 2006-10-03 at 21:39 -0700, Jeremy Fitzhardinge wrote:
> 
> > 
> > I don't think you've proved your case here.  Do you *know* there are 
> > extra cache misses (ie, measuring them), or is it just your theory to 
> > explain a performance regression?
> > 
> 
> I have measured the cache miss with tool.  So it is not just my theory.
> 

And what did that tool tell you?

Guys.  Please.  Help us out here.  None of this makes sense, and it's
possible that we have an underlying problem in there which we need to know
about.

Please don't just ignore my questions.  *why* are we getting a cache miss
rate on that integer which is causing measurable performance changes?  If
we're reading it that frequently then the variable should be in cache(!).

Again: do you know which callsite is causing the problem?  I assume one of
the ones in softirq.c?  Do you know what the cache miss frequency is?  etc.

Because if we don't answer these questions there's an excellent chance that
the problem (whatever it is) will come back and bite us again.
