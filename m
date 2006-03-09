Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWCIR4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWCIR4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWCIR4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:56:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751199AbWCIR4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:56:44 -0500
Date: Thu, 9 Mar 2006 09:56:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
In-Reply-To: <Pine.LNX.4.64.0603090947290.18022@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603090954420.18022@g5.osdl.org>
References: <Pine.LNX.4.64.0603090814530.18022@g5.osdl.org> 
 <1141855305.10606.6.camel@localhost.localdomain> <20060308161829.GC3669@elf.ucw.cz>
 <31492.1141753245@warthog.cambridge.redhat.com> <24309.1141848971@warthog.cambridge.redhat.com>
 <24280.1141904462@warthog.cambridge.redhat.com>  <12101.1141925945@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0603090947290.18022@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Mar 2006, Linus Torvalds wrote:
> 
> So the fact that x86 SMP ops basically never guarantee any bus cycles 
> basically means that they are fundamentally no-ops when it comes to IO 
> serialization. That was really my only point.

Side note: of course, locked cycles _do_ "serialize" the core. So they'll 
stop at least the core write merging, and speculative reads. So they do 
have some impact on IO, but they have no way of impacting things like 
write posting etc that is outside the CPU.

			Linus
