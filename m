Return-Path: <linux-kernel-owner+w=401wt.eu-S932085AbWLSJkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWLSJkV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWLSJkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:40:20 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:46648 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbWLSJkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:40:19 -0500
Date: Tue, 19 Dec 2006 02:40:18 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lock debugging: fix DEBUG_LOCKS_WARN_ON() & debug_locks_silent
Message-ID: <20061219094017.GM21070@parisc-linux.org>
References: <20061216080458.GC16116@elte.hu> <20061219084359.GB1731@ff.dom.local> <20061219093135.GA28269@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219093135.GA28269@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 10:31:35AM +0100, Ingo Molnar wrote:
> 
> * Jarek Poplawski <jarkao2@o2.pl> wrote:
> 
> > >  	if (unlikely(c)) {						\
> > > -		if (debug_locks_silent || debug_locks_off())		\
> > > +		if (!debug_locks_silent && debug_locks_off())		\
> 
> btw., updated patch is below - the right order is to first do 
> debug_locks_off(), then debug_locks_silent.

Then how does one re-enable lock debugging after running the locking
testsuite?
