Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWGMTWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWGMTWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWGMTV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:21:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23783 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030305AbWGMTV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:21:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: olson@pathscale.com
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, discuss@x86-64.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	<m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	<p734pxnojyt.fsf@verdi.suse.de>
	<m1wtajed4d.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0607112307130.10551@osa.unixfolk.com>
	<m1psgbcnv9.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0607122048230.4819@topaz.pathscale.com>
	<m1d5c94jx8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0607131109540.3583@topaz.pathscale.com>
	<m1ac7d1h6g.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0607131158300.3583@topaz.pathscale.com>
Date: Thu, 13 Jul 2006 13:20:59 -0600
In-Reply-To: <Pine.LNX.4.64.0607131158300.3583@topaz.pathscale.com> (Dave
	Olson's message of "Thu, 13 Jul 2006 12:00:59 -0700 (PDT)")
Message-ID: <m1fyh5z4ys.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olson <olson@pathscale.com> writes:

> On Thu, 13 Jul 2006, Eric W. Biederman wrote:
> | > There's really nothing special at all about the interrupt
> | > setup, except in one very minor way.   The value of the HT interrupt
> | > destination address needs to be copied from HT config space, to
> | > an internal chip register (which is, can, and should be, handled by
> | > the driver init code).
> | 
> | The kernel changes the value at runtime, based upon user input.
> | I assume your mirror register needs to be updated after every change.
>
> Yes.  If the interrupt address changes, then we need a callback.
>
> | Since the kernel changes the value at runtime, and since a different
> | register needs to be written to, I can't quite use the generic code I
> | have written as is.  
>
> I imagine at least some other drivers would like to know when their interrupt
> configuration changes, also, so an interface where a driver can register
> a callback handler seems like the right generic answer, or more simply,
> a way for a driver to say it doesn't want it's interrupt handler
> migrated (which we would like anyway, for performance reasons).

As I recall that is "killall irqbalanced"

Eric
