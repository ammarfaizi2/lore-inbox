Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWD1Mrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWD1Mrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 08:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWD1Mrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 08:47:46 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:6358 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030368AbWD1Mrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 08:47:46 -0400
Date: Fri, 28 Apr 2006 07:48:23 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Message-ID: <20060428114823.GA3641@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org> <m1d5feotur.fsf@ebiederm.dsl.xmission.com> <20060426180110.GB8142@ccure.user-mode-linux.org> <200604281333.41358.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604281333.41358.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 01:33:40PM +0200, Blaisorblade wrote:
> > So, maybe it belongs in clone as a "backwards" flag similar to
> > CLONE_NEWNS.
> 
> I must note that currently every (?) flag allowed for unshare is also allowed
> for clone, so you need to do that anyway.

Currently.  We are running out of CLONE_ bits - in mainline, there are
three left, and two of them are likely to be used by CLONE_TIME and
CLONE_UTSNAME (or whatever that turns out to be called).

I'm eyeing the low eight bits (CSIGNAL) for future unshare flags, but
those would be unusable in clone().

And why should there be any overlap between clone flags and unshare
flags?  Isn't 
	clone(CLONE_TIME);
the same as 
	clone();
	unshare(CLONE_TIME);
?

				Jeff
