Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVFAOHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVFAOHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVFAOHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:07:46 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:25015 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261327AbVFAOHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:07:44 -0400
Date: Wed, 1 Jun 2005 16:07:03 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com, rostedt@goodmis.org,
       inaky.perez-gonzalez@intel.com
Subject: Re: [PATCH] Abstracted Priority Inheritance for RT
In-Reply-To: <Pine.LNX.4.10.10506010542420.23911-100000@godzilla.mvista.com>
Message-Id: <Pine.OSF.4.05.10506011603560.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Daniel Walker wrote:

> 
> 
> On Wed, 1 Jun 2005, Ingo Molnar wrote:
> 
> > i'd rather not slow things down by callbacks and other abstraction 
> > before seeing how things want to integrate in fact. Do we really need 
> > the callbacks?
> 
> I think it would be hard to do without a way to signal when a waiter
> changes priorties.

Do you plan to use that callback for priority inheritance?
If so: It would lead to an recursive algorithm. That is not very nice in
the kernel with a limited call-stack. It is not so much a problem if the
mechanism is used in the kernel only, but if it is used for user-space
locking, which can have unlimited neesting, it is potential problem.

Esben

> [...] 
> 
> Daniel
> 

