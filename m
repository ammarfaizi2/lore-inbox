Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWBBMtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWBBMtD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWBBMtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:49:03 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:3544 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751014AbWBBMtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:49:01 -0500
Date: Thu, 2 Feb 2006 14:48:50 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Nigel Cunningham <nigel@suspend2.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
In-Reply-To: <200602022144.40238.nigel@suspend2.net>
Message-ID: <Pine.LNX.4.58.0602021446370.13469@sbz-30.cs.Helsinki.FI>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
 <200602012245.06328.nigel@suspend2.net> <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com>
 <200602022144.40238.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 23:01, Pekka Enberg wrote:
> > > +
> > > +static inline void suspend_initialise_module_lists(void) {
> > > +       INIT_LIST_HEAD(&suspend_filters);
> > > +       INIT_LIST_HEAD(&suspend_writers);
> > > +       INIT_LIST_HEAD(&suspend_modules);
> > > +}
> >
> > I couldn't find a user for this. I would imagine there's only one,
> > though, and this should be inlined there?

On Thu, 2 Feb 2006, Nigel Cunningham wrote:
> I forgot to mention re this - yes, there's just one caller, in another set of 
> patches I'll send later (this was just the first set!). Having the function 
> to be inlined in this .h so that it's with other module specific code, and 
> then used in the caller once it has been #included, isn't that the right way 
> to do things?

Sorry, I can't parse the above :-). My point was that this is 
probably called in a .c file so move the function in that file and 
introduce it whenever you introduce the caller.

			Pekka
