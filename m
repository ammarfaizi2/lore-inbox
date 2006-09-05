Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbWIEG4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWIEG4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 02:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWIEG4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 02:56:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965167AbWIEG4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 02:56:07 -0400
Date: Mon, 4 Sep 2006 23:55:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Voluspa <lista1@comhem.se>
Cc: arjan@infradead.org, arjan@linux.intel.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: [PATCH] lockdep: disable lock debugging when kernel state
 becomes untrusted
Message-Id: <20060904235549.f8f6eaab.akpm@osdl.org>
In-Reply-To: <20060905084042.20966381.lista1@comhem.se>
References: <20060814030954.c3a57e05.lista1@comhem.se>
	<20060813184159.b536736f.akpm@osdl.org>
	<20060905084042.20966381.lista1@comhem.se>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2006 08:40:42 +0200
Voluspa <lista1@comhem.se> wrote:

> > That would appear to be a bug.  debug_locks_off() is running
> > console_verbose() waaaay after the locking selftest code has
> > completed.
> 
> The possibly final -rc6 is likewise broken. What would it take to incur
> some respect for us, the millions of users effected by this shit?
> Should we all become quasi-developers and bombard lkml with patches
> that taint the kernel whenever some of the Intel binary blobs are
> loaded?
> 
> Would that cluebat Arjan off of his high horse?

Thanks for the reminder ;)

Arjan, what's that console_verbose() doing in debug_locks_off()?  Whatever
it is, can we fix it?  Presumably the previous loglevel needs to be
readopted somehow, or we just take it out of there.

