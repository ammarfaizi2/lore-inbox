Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWDXNpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWDXNpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDXNpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:45:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4256 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750787AbWDXNpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:45:30 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Joshua Brindle <method@gentoo.org>, Neil Brown <neilb@suse.de>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <200604241526.03127.ak@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <17484.20906.122444.964025@cse.unsw.edu.au> <444CCE83.90704@gentoo.org>
	 <200604241526.03127.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 14:52:47 +0100
Message-Id: <1145886783.29648.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 15:26 +0200, Andi Kleen wrote:
> On Monday 24 April 2006 15:11, Joshua Brindle wrote:
> 
> > Sure but if, instead, it's able to open /var/chroot/etc/shadow which is 
> > a hardlink to /etc/shadow you've bought nothing. You may filter out 
> > worms and script kiddies this way but in the end you are using obscurity 
> > (of filesystem layout, what the policy allows, how the apps are 
> > configured, etc) for security, which again, leads to a false sense of 
> > security.
> 
> AppArmor disallows both chroot and name space changes for the constrained
> application so the scenario you're describing cannot happen. What happens
> with unconstrained applications it doesn't care about by design.
> 
> This has been covered several times in this thread already - please pay
> more attention.

There is a much simpler answer anyway, sit in a loop trying to
open /etc/shadow~ and wait for someone to change password. All the
problems about names remain because of links anyway.

