Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTLHWA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 17:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTLHWA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 17:00:59 -0500
Received: from imap.gmx.net ([213.165.64.20]:11229 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261881AbTLHWA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 17:00:57 -0500
Date: Mon, 8 Dec 2003 23:00:55 +0100 (MET)
From: "Peter Bergmann" <bergmann.peter@gmx.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, kristian.peters@korseby.net,
       nfedera@esesix.at, andrea@suse.de, riel@redhat.com
MIME-Version: 1.0
References: <Pine.LNX.4.44.0312081512510.1289-100000@logos.cnet>
Subject: Re: Configurable OOM killer Re: old oom-vm for 2.4.32 (was oom killer in 2.4.23)
X-Priority: 3 (Normal)
X-Authenticated: #13246506
Message-ID: <26836.1070920855@www56.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sat, 6 Dec 2003, Peter Bergmann wrote:
> 
> > > > If anyone  is interested:
> > > > Norbert Federa sent me this link for a "quick&dirty" patch he made 
> > > > for 2.4.23-vanilla which rolls back the complete 2.4.22 vm including
> the
> > > > old oom-killer  - without guarantee but it does work very well for
> me
> > > ...
> > > 
> > > I suppose the oom killer is the only reason for you using .22 VM
> correct?
> > > 
> > > Or do you have any other reason for this?
> > 
> > No, you're right. The oom killer is the _only_reason. 
> > I did not succeed in integrating the disabled oom_kill.c in 2.4.23.
> > The only solution for me is applying Norbert's .22vm patch.
> 
> Hi,
> 
> The following patch makes OOM killer configurable (its the same as the 
> other patches posted except its around CONFIG_OOM_KILLER).
> 
> I hope the Configure.help entry is clear enough.
> 
> Peter, can you please try this.
> 
> Comments are appreciated.

Great. seems to work very well. Thx.
Ran some very hungry testprogs (memeat.c), filled a tmpfs with crap, ... 
I was satisfied with oom's kill decisions.
And it is/was very easy to modify/extend oom_kill.c  for special needs.

Maybe the Configure.help text should be somewhat more frightening.
I think aa had good reasons for disabling oom (possibility of lock up) but
among others 
I'd prefer to see your patch - a config option (default disabled +
experimental)  - in 2.4.24.

Cheers,
Pet

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


