Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752010AbWG2Qm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbWG2Qm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 12:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWG2Qm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 12:42:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751302AbWG2Qm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 12:42:58 -0400
Date: Sat, 29 Jul 2006 12:42:38 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: Do backtrace fallback too
Message-ID: <20060729164238.GB16946@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <200607290300.k6T306Fc003168@hera.kernel.org> <20060729075414.GA16118@redhat.com> <200607291835.54379.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607291835.54379.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 06:35:54PM +0200, Andi Kleen wrote:

 > >  >  arch/i386/kernel/traps.c |   17 ++++++++++++++---
 > >  >  1 files changed, 14 insertions(+), 3 deletions(-)
 > >
 > > Hmm, this breaks the build for me..
 > 
 > Hmm, it definitely builds here. Ah do you have UNWIND_INFO
 > disabled? 

That was with it enabled iirc, I'll double check and do another
build later (though you may want to look at Erik Mouw's reply)
 
 > > 	print_symbol("DWARF2 unwinder stuck at %s\n",
 > > 		UNW_PC(info.regs));
 > >
 > > be using %p ?
 > 
 > Yes good catch.

The x86-64 equivalent also has an instance of the same bug.

		Dave

-- 
http://www.codemonkey.org.uk
