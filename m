Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272285AbRIKFep>; Tue, 11 Sep 2001 01:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272289AbRIKFef>; Tue, 11 Sep 2001 01:34:35 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:34320 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S272285AbRIKFeS>; Tue, 11 Sep 2001 01:34:18 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andreas Steinmetz <ast@domdv.de>
Date: Tue, 11 Sep 2001 15:34:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15261.41564.349012.114622@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reboot notifier priority definitions
In-Reply-To: message from Andreas Steinmetz on Tuesday September 11
In-Reply-To: <15261.26206.601070.598763@notabene.cse.unsw.edu.au>
	<XFMail.20010911032626.ast@domdv.de>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday September 11, ast@domdv.de wrote:
> > 
> > I think this misses the point of reboot notifiers (as I understand
> > it).
> > 
> > There are *only* meant for "physical" sorts of things.
> > The comment in the code says:
> >  *    Notifier list for kernel code which wants to be called
> >  *    at shutdown. This is used to stop any idling DMA operations
> >  *    and the like. 
> > 
> > md, lvm, knfsd and tux have no business registering a reboot notifier.
> > If they have something to shut down, it should be shut down in a
> > higher-level way, such as when a process gets a signal. 
> > 
> Even then: My servers do have watchdog cards. Unfortunately without the
> priority definitions the watchdog card was shut down prior to the oops. Thus,
> due to missing priority, the system did require hitting the reboot button.
> So some well defined priorization is still required.

Fair enough.

Maybe we need one priority for devices,
A lower priority for busses,
An even lower one for watchdogs,

or something like that.
I'll leave to to people who understand hardware configurations and
controllers better than me.

NeilBrown
