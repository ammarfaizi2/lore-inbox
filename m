Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWFSXav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWFSXav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWFSXav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:30:51 -0400
Received: from web50205.mail.yahoo.com ([206.190.38.46]:40797 "HELO
	web50205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964979AbWFSXau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:30:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OCwAYghSRoLKU71Ukm8zsNgKGEi6tV+mWgY6BeqY6W20aZsZn2Xhar4PPStgVUAf5DUOrkv7FTeLEg4ULeabxttEhFA/5nMzRguJTQ9pFMY7eECMohnEpZdR10K4LozhpQu3aK/1lHZyDhwS7t3FnAqDOrenhJ537zVLNBDerJg=  ;
Message-ID: <20060619233049.67325.qmail@web50205.mail.yahoo.com>
Date: Mon, 19 Jun 2006 16:30:49 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Kernel panic when re-inserting Adaptec PCMCIA card
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alex Davis <alex14641@yahoo.com> wrote:

> --- Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
> > In-Reply-To: <20060614022139.21737.qmail@web50208.mail.yahoo.com>
> > 
> > On Tue, 13 Jun 2006 19:21:39 -0700, Alex Davis wrote:
> > 
> > Same panic occurs in 2.6.17rc6:
> > 
> > > Jun 13 17:50:36 siafu kernel: [4295220.230000] pccard: PCMCIA card inserted into slot 0
> > > Jun 13 17:50:36 siafu kernel: [4295220.230000] pcmcia: registering new device pcmcia0.0
> > > Jun 13 17:50:37 siafu kernel: [4295220.281000] aha152x: resetting bus...
> > > Jun 13 17:50:37 siafu kernel: [4295220.637000] aha152x13: vital data: rev=1, io=0xd340
> > > (0xd340/0xd340), irq=3, scsiid=7, reconnect=enabled,
> > >  parity=enabled, synchronous=enabled, delay=100, extended translation=disabled
> > > Jun 13 17:50:37 siafu kernel: [4295220.637000] aha152x13: trying software interrupt, ok.
> > > Jun 13 17:50:37 siafu kernel: [4295221.638000] scsi13 : Adaptec 152x SCSI driver; $Revision:
> > 2.7 $
> > > Jun 13 17:50:37 siafu kernel: [4295221.650000]
> > > Jun 13 17:50:37 siafu kernel: [4295221.650000] aha152x22856: bottom-half already running!?
> > > Jun 13 17:50:37 siafu kernel: [4295221.650000]
> > > Jun 13 17:50:37 siafu kernel: [4295221.650000] queue status:
> > > Jun 13 17:50:37 siafu kernel: [4295221.650000] issue_SC:
> > > Jun 13 17:50:37 siafu kernel: [4295221.650000] current_SC:
> > > Jun 13 17:50:37 siafu kernel: [4295221.650000] BUG: unable to handle kernel paging request
> at
> > > virtual address 00020016
> > 
> > Something is going very wrong here.  At time .637 it says it is
> > adapter number 13 (aha152x13.)  Then at .650 it thinks it's
> > adapter nr. 22856 (!)  Looks like some kind of pointer to the
> > hostdata is corrupted.
> > 
> > Can you rmmod the driver after removing the card and see if that
> > helps?
> > 
> It turns out I was trying to remove the driver before doing 'pccardctl eject'.
> 
> It seems that removing the driver after ejecting make the problem go away:
> I ejected and re-inserted the card six times with no crash.
> 
> I'll continue testing just to make sure.
> 
Will removing the module after ejecting be considered the fix 
for this problem??


I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
