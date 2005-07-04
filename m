Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVGDMoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVGDMoC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVGDMoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:44:02 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:62943 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261654AbVGDMhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:37:41 -0400
Date: Mon, 4 Jul 2005 07:37:21 -0500
From: serge@hallyn.com
To: Kurt Garloff <garloff@suse.de>, Tony Jones <tonyj@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>,
       Linux LSM list <linux-security-module@wirex.com>
Subject: Re: [PATCH 3/3] Use conditional
Message-ID: <20050704123721.GA28322@vino.hallyn.com>
References: <20050703154405.GE11093@tpkurt.garloff.de> <20050703190007.GA30292@immunix.com> <20050704065902.GO11093@tpkurt.garloff.de> <20050704074449.GA12963@immunix.com> <20050704120105.GB27617@vino.hallyn.com> <20050704120809.GR11137@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704120809.GR11137@tpkurt.garloff.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Quoting Kurt Garloff (garloff@suse.de):
> Getting rid of dummy entirely would be better, I agree, but someone
> needs to review that this won't break anything.

Unfortunately I think it's way too soon for that.  Even if stacker is
accepted, it is still a module (for now at least) which can be compiled
out.  So we'll need dummy hooks for modules (like seclvl) to use.  I
just don't think it's possible to get rid of that yet.

> So how should we proceed?
> You want to do the dummy removal first, then have stacker merged
> and then what remains of my patches? Or should I start ... ?

I think your patches to make capability the default are the best
place to start.  Doing the same under stacker will be trivial, and
I'll do that in the next set I send out.

thanks,
-serge
