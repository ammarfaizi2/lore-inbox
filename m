Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVKKX1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVKKX1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVKKX1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:27:12 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:63210 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751312AbVKKX1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:27:12 -0500
Subject: Re: [PATCH] getrusage sucks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@osdl.org>
Cc: Claudio Scordino <cloud.of.andor@gmail.com>,
       "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, David Wagner <daw@cs.berkeley.edu>
In-Reply-To: <20051111230223.GB7991@shell0.pdx.osdl.net>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com>
	 <200511110211.05642.cloud.of.andor@gmail.com>
	 <1131715816.3174.15.camel@localhost.localdomain>
	 <200511112338.20684.cloud.of.andor@gmail.com>
	 <1131751433.3174.50.camel@localhost.localdomain>
	 <20051111230223.GB7991@shell0.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Nov 2005 23:58:16 +0000
Message-Id: <1131753496.3174.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-11 at 15:02 -0800, Chris Wright wrote:
> * Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> > On Gwe, 2005-11-11 at 23:38 +0100, Claudio Scordino wrote:
> > > +                if ((current->euid != tsk->euid) &&
> > > +                (current->euid != tsk->uid)) {
> > > +                        read_unlock(&tasklist_lock);
> > > +                        return -EINVAL;
> > 
> > 
> > Would be -EPERM also wants a 'privilege' check. Not sure which would be
> > best here - CAP_SYS_ADMIN seems to be the 'default' used
> 
> It's already available via /proc w/out protection.  And ditto via posix
> cpu timers.

In which case the only comment I have is the one about accuracy - and
that is true for procfs too so will only come up if someone gets the
urge to use perfctr timers for precision resource management

