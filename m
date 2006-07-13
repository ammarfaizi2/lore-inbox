Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWGMAwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWGMAwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 20:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWGMAwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 20:52:30 -0400
Received: from thunk.org ([69.25.196.29]:65442 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750742AbWGMAwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 20:52:30 -0400
Date: Wed, 12 Jul 2006 20:52:18 -0400
From: Theodore Tso <tytso@mit.edu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
Message-ID: <20060713005218.GK9040@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Arjan van de Ven <arjan@infradead.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel@vger.kernel.org
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com> <200607121652.21920.ak@suse.de> <m1lkqyc00d.fsf@ebiederm.dsl.xmission.com> <200607121808.26555.ak@suse.de> <m1ac7ebx0v.fsf@ebiederm.dsl.xmission.com> <20060712112432.0cd5996f@dxpl.pdx.osdl.net> <1152734309.3217.71.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152734309.3217.71.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 09:58:29PM +0200, Arjan van de Ven wrote:
> On Wed, 2006-07-12 at 11:24 -0700, Stephen Hemminger wrote:
> > What is the motivation behind killing the sys_sysctl call anyway?
> > Sure its more ugly esthetically but it works.
> 
> it "works" but the thing is that the number space is NOT stable, and as
> such it's a really bad ABI

To be fair, the older, "base" numbers are actually stable, such as
what glibc is depending on, have in practice been quite stable.  It's
only the newer fields that tend to be unstable.

But that means we can afford to do an orderly migration away from it;
it's not something that has to be urgently done within a few weeks or
even a few months.

						- Ted
