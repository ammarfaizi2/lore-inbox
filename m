Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVL3SgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVL3SgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 13:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVL3SgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 13:36:11 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:5644 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751275AbVL3SgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 13:36:09 -0500
Date: Fri, 30 Dec 2005 19:33:08 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com, alan@redhat.com
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Message-ID: <20051230183308.GA2501@w.ods.org>
References: <20051230074401.GA7501@ip68-225-251-162.oc.oc.cox.net> <20051230174817.GW15993@alpha.home.local> <1135966666.2941.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135966666.2941.32.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 07:17:46PM +0100, Arjan van de Ven wrote:
> On Fri, 2005-12-30 at 18:48 +0100, Willy Tarreau wrote:
> > On Thu, Dec 29, 2005 at 11:44:01PM -0800, Barry K. Nathan wrote:
> > > This patch adds strict VM overcommit accounting to the mainline 2.4
> > > kernel, thus allowing overcommit to be truly disabled. This feature
> > > has been in 2.4-ac, Red Hat Enterprise Linux 3 (RHEL 3) vendor kernels,
> > > and 2.6 for a long while.
> > 
> > Many thanks, I'm impatient to try it ! I tried to backport it in the
> > past but miserably failed as I don't understand those areas well. I'm
> > interested in checking that a buggy service cannot eat all the RAM an
> > bring the machine to death.
> 
> that's what rlimit is for though... overcommit acounting doesn't help
> you a lot there.

Not always. When you have buggy apache modules eating lots of memory and
you have tons of processes, rlimit will be of limited help.

> Also I think, to be honest, that this is a feature that is getting
> unsuitable for the "bugfixes only" 2.4 kernel series....

Agreed, it really is too late IMHO, because there's a non-null risk of
introducing new bugs with it. It would have been cool a few months
earlier. That won't stop me from trying it in my own tree however ;-)

Willy

