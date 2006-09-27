Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965345AbWI0FbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965345AbWI0FbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965346AbWI0FbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:31:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:60560 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965345AbWI0FbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:31:05 -0400
Date: Tue, 26 Sep 2006 22:14:18 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Pavel Machek <pavel@ucw.cz>, Willy Tarreau <w@1wt.eu>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060927051418.GB452@kroah.com>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923045610.GM541@1wt.eu> <20060923232150.GK5566@stusta.de> <20060924101753.GB4813@ucw.cz> <20060925012322.GE4547@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925012322.GE4547@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 03:23:22AM +0200, Adrian Bunk wrote:
> On Sun, Sep 24, 2006 at 10:17:53AM +0000, Pavel Machek wrote:
> > Hi!
> > 
> > > > Adrian, when you have a doubt whether such a fix should go into next
> > > > release, simply tell people about the problem and ask them to test
> > > > current driver. If nobody encounters the problem, you can safely keep
> > > > the patch in your fridge until someone complains. By that time, the
> > > > risks associated with this patch will be better known.
> > > 
> > > It's not that I wanted to upgrade ACPI to the latest version.
> > > 
> > > And my rules are:
> > > - patch must be in Linus' tree
> > > - I'm asking the patch authors and maintainers of the affected subsystem
> > >   whether the patch is OK for 2.6.16
> > 
> > I thought stable rules were longer than this... including 'patch must
> > be < 100 lines' and 'must be bugfix for serious bug'. Changing rules
> > for -stable series in the middle of it seems like a bad idea...
> 
> I stated what I'd do with 2.6.16 before I took over maintainance.

No you did not...

{dig, dig, dig}  Ah, here we go:

I stated in the original announcement with message id
<20060803204921.GA10935@kroah.com>:

	He will still be following the same -stable rules that are
	documented in the Documentation/stable_kernel_rules.txt file,
	but just doing this for the 2.6.16 kernel tree for a much longer
	time than the current stable team is willing to do (we have
	moved on to the 2.6.17 kernel now.)


And I said that based on a message you wrote to stable@kernel.org where
you stated:
	My primary goal is to follow these rules.

	But there will also be cases like "adding a PCI id to a driver"
	that wouldn't fit the wording of the your -stable release rules.

	OTOH, I remember e.g. releases/2.6.12.3/smp-fix-for-6pack.patch
	being added despite me disagreeing with this - and this did
	equally not match the -stable rules.

	Especially if the tree will be accepted and used for a long
	time, there will be a need for moderate hardware updates. But
	2.4 and 2.6 have different rules, people quickly learned that
	-rc is Linus' newspeak for -pre ;-) and similar things, so I
	doubt the confusion will be that big (people will either use the
	current stable kernel or the 2.6.16 branch - and people using
	the latter will know the difference (otherwise they wouldn't use
	an older branch instead of the latest stable kernel)).

Hm, ok, I guess you did say this in the beginning, but only to a small
subset of us.  And I misinterpreted it too in my original announcement.

Ok, I withdraw my objection, only to note that this is going to cause
your tree to diverge even more than expected, which might cause bigger
problems in the end.

good luck,

greg k-h
