Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWBKPpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWBKPpF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWBKPpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:45:05 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:18333 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932329AbWBKPpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:45:04 -0500
Date: Sat, 11 Feb 2006 16:44:48 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Doug McNaught <doug@mcnaught.org>
Cc: Marc Koschewski <marc@osknowledge.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git
Message-ID: <20060211154448.GE5721@stiffy.osknowledge.org>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com> <20060210210006.GA5585@stiffy.osknowledge.org> <43ED04E9.9040900@cfl.rr.com> <Pine.LNX.4.61.0602111614050.17942@yvahk01.tjqt.qr> <20060211152518.GB5721@stiffy.osknowledge.org> <87u0b5sybs.fsf@asmodeus.mcnaught.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0b5sybs.fsf@asmodeus.mcnaught.org>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g25bf368b-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Doug McNaught <doug@mcnaught.org> [2006-02-11 10:35:19 -0500]:

> Marc Koschewski <marc@osknowledge.org> writes:
> 
> > The cdrecord man page says this:
> >
> > 	Setting the -immed flag will request the command to return
> > 	immediately while the operation proceeds in background, making
> > 	the bus usable for the other devices and avoiding the system
> > 	freeze.  This is an experimental feature which may work or
> > 	not, depending on the model of the CD/DVD writer.  A correct
> > 	solution would be to set up a correct cabling but there seem
> > 	to be notebooks around that have been set up the wrong way by
> > 	the manufacturer.  As it is impossible to fix this problem in
> > 	notebooks, the -immed option has been added.
> 
> > It how can the bus run the command sent on the device 'in the
> >background' when it can only process _one_ request at a time?
> >
> > To me it sound like the foreground process (cdrecord) fork()s a
> >process to blank the CD-RW. Clear. But you said the bus is not able
> >to do so... I'm not getting this.
> 
> Some CD writers are apparently able to release the bus while
> blanking, allowing use of the bus by other devices.  The 'immed' flag
> tries to use this feature.  fork() has nothing to do with it--he's
> talking about the IDE command, not the cdrecord program.

I just thought about fork() as Alan (surely and others) told the IDE bus cannot
run several commands at a time. So fork() was the only left-over I could think
of. I didn't know some devices can kinda 'detach' themselves as long as the
blank is going on...

Things are clear now. OK, more clear. Not clear. ;)

Marc
