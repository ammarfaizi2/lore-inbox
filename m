Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSJDUQa>; Fri, 4 Oct 2002 16:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbSJDUOi>; Fri, 4 Oct 2002 16:14:38 -0400
Received: from 62-190-217-49.pdu.pipex.net ([62.190.217.49]:57604 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262383AbSJDUOU>; Fri, 4 Oct 2002 16:14:20 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210042028.g94KSBqN008008@darkstar.example.net>
Subject: Re: aic7xxx problems?
To: dledford@redhat.com (Doug Ledford)
Date: Fri, 4 Oct 2002 21:28:11 +0100 (BST)
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021004184153.GA1916@redhat.com> from "Doug Ledford" at Oct 04, 2002 02:41:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >> Actually, in reviewing your message more fully, the problem is that
> > >> the timeout for the rewind operation is too short for your 
> > >> configuration.
> > >> The timeout should go away if you bump up the timeout in the st driver
> > >> so that your tape drive can rewind in peace.
> > > 
> > > The rewind is not *that* long, about 60 seconds...
> > 
> > Well, we are still waiting on the drive to do something, so its not
> > the aic7xxx driver's fault.
> 
> It's possible that the controller could have disconnect disabled for the 
> tape drive, causing it to hold the bus the entire time and making other 
> commands time out (although unlikely unless someone actually went in and 
> turned it off in the adapter config...)

Have you checked the settings in the adaptor's own BIOS?  Most, (all?), Adaptec cards let you change things like disconnect, and sync negotiation, etc, etc, on a per device basis.  Just press control-A, to run the SCSI-Select utility at boot up.

Also, do you have the latest firmware for your card?  If it is a genuine Adaptec card, _not_ an OEM one, then I believe that they will send you a new BIOS for it.

John.
