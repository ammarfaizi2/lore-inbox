Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270093AbTGPDOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 23:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270097AbTGPDOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 23:14:00 -0400
Received: from tantale.fifi.org ([216.27.190.146]:22666 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S270093AbTGPDN7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 23:13:59 -0400
To: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Cc: linux-kernel@vger.kernel.org, amd-dev@cs.columbia.edu
Subject: Re: am-utils or kernel bug ? Seems to be kernel  bug.. Any news ?
References: <1058258041.19183.18.camel@atlas.inria.fr>
	<87isq3uabz.fsf@ceramic.fifi.org>
	<1058285921.19183.63.camel@atlas.inria.fr>
From: Philippe Troin <phil@fifi.org>
Date: 15 Jul 2003 20:28:47 -0700
Message-ID: <87znjfup3k.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Turro <Nicolas.Turro@sophia.inria.fr> writes:

> On Tue, 2003-07-15 at 16:35, Philippe Troin wrote:
> > Nicolas Turro <Nicolas.Turro@sophia.inria.fr> writes:
> > 
> > > Hi, i posted a bug about amd hanging at boot time a few week ago,
> > > does anybody has a fix for it ?
> > > The bug is described here :
> > > 
> > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=90902
> > > 
> > > it seems that several groups of users besides me encounter the same
> > > bug....
> > > 
> > > If not, i'll have to post-install a 2.4.18 kernel on all my new
> > > RH9 boxes :-(
> > 
> > Looks like YAFP (Yet Another Futex Problem).
> > 
> > Have you tried running with LD_ASSUME_KERNEL=2.2.5 ?
> 
> You are right, setting LD_ASSUME_KERNEL=2.2.5 (or
> LD_ASSUME_KERNEL=2.4.1) corrects the problem.
> Do you have more info on this ´bug'  ?

As a rule of thumb, whenever a program deadlocks in a futex call,
setting this variable to a < 2.5.x value might prevent the deadlock.
Google around for the exact reason why.

AFAIU, it's a RH 9.0 bug.

Phil.
