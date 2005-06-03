Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVFCJJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVFCJJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 05:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVFCJJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 05:09:35 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:49896 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261196AbVFCJJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 05:09:32 -0400
Date: Fri, 3 Jun 2005 11:08:57 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
In-Reply-To: <1117749028.20350.12.camel@dhcp153.mvista.com>
Message-Id: <Pine.OSF.4.05.10506030938390.3853-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Daniel Walker wrote:

> On Thu, 2005-06-02 at 22:27 +0200, Esben Nielsen wrote:
> 
> > But right now the following ideas spring to my mind:
> > If it is to solve the problem of having a callback wrap every use
> > in macroes and use the TYPE_EQUAL() to expclicit call the right function.
> > Only if the explicit type is unknown in the macro use the callback. That
> > should optimize stuff a little bit.. Just a wild idea.
> 
> It's a little hard to do that. It's basically the situation you have
> below, there is no way to know what "waiter" is at compile time, so you
> can't really do the TYPE_EQUAL() trick on "get_next_waiter" .
> 
> I have "waiter->waiter_changed_prio()" which results in the same
> problem. There is no way to know what "type" waiter is at compile
> time .. 
> 
> 
> > If it is explicitly for PI you can do a thing like
> >  waiter->get_next_waiter();
> > to resolve the chain of waiters. Then you can have the PI algotithm work
> > iteratively without knowing the explicit kind of lock involved.
> 
> This is essentially what I have now, but it's also what I'm unhappy
> with. The only reason that I don't like this method is that it's a
> little slow .. I don't mind keeping it as long as no better way presents
> itself. 
> 
> Daniel
> 
C++ templates would have helped a lot...  But we only have the low
tech version: macroes.

Esben

