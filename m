Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVKKXCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVKKXCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVKKXCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:02:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751310AbVKKXCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:02:39 -0500
Date: Fri, 11 Nov 2005 15:02:23 -0800
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Claudio Scordino <cloud.of.andor@gmail.com>,
       "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, David Wagner <daw@cs.berkeley.edu>
Subject: Re: [PATCH] getrusage sucks
Message-ID: <20051111230223.GB7991@shell0.pdx.osdl.net>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <200511110211.05642.cloud.of.andor@gmail.com> <1131715816.3174.15.camel@localhost.localdomain> <200511112338.20684.cloud.of.andor@gmail.com> <1131751433.3174.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131751433.3174.50.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Gwe, 2005-11-11 at 23:38 +0100, Claudio Scordino wrote:
> > +                if ((current->euid != tsk->euid) &&
> > +                (current->euid != tsk->uid)) {
> > +                        read_unlock(&tasklist_lock);
> > +                        return -EINVAL;
> 
> 
> Would be -EPERM also wants a 'privilege' check. Not sure which would be
> best here - CAP_SYS_ADMIN seems to be the 'default' used

It's already available via /proc w/out protection.  And ditto via posix
cpu timers.
