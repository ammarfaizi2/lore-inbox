Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVCJMBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVCJMBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVCJMBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:01:23 -0500
Received: from mail.tmr.com ([216.238.38.203]:60943 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262535AbVCJMBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:01:19 -0500
Date: Thu, 10 Mar 2005 06:49:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make st seekable again
In-Reply-To: <1110407237.28860.259.camel@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1050310064102.10287B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Alan Cox wrote:

> On Mer, 2005-03-09 at 21:58, Kai Makisara wrote:
> > While waiting for the application to be fixed, it was decided to restore 
> > the old behaviour of the tape drivers.
> 
> Which means tar won't get fixed 8(

Bet that's true.
> 
> > I don't think implementing proper read-only lseek for tapes is worth the 
> > trouble (reliable tracking of the current location is tricky). Purist 
> > kernels can refuse lseeks. Pragmatic kernels can allow lseeks until 
> > refusing those won't break common applications.
> 
> The problem is the existing behaviour code isn't just 'not useful' its
> badly broken. No locking, no overflow checks, updates the wrong variable
> etc. It is asking for nasty accidents with critical user data.

In other words, it should work correctly or not at all. At the least this
should be a config option, like UNSAFE_TAPE_POSITIONING or some such.
And show the option if the build includes BROKEN features. That should put
the decision where it belongs and clarify the possible failures.

Caould you live with that, Alan?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

