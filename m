Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbTGLTyg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268383AbTGLTyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:54:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:58273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268294AbTGLTye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:54:34 -0400
Date: Sat, 12 Jul 2003 13:09:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Arjan van de Ven <arjanv@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Deprecate sysctl(2), add sysctl_name
In-Reply-To: <20030711102146.GB11119@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0307121305040.2483-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jul 2003, Andi Kleen wrote:
> 
> Also I doubt sysctls are that commonly called if they are even used.

It looks like kudzu (also known as "the RH hardware hack from h*ll") 
actually messes with "sysctl 1 23", aka "/proc/sys/kernel/printk".

Why it thinks it should mess with it I don't know. I dislike how the 
distributions tend to shut off kernel messages that can tell you when
something is seriously wrong, making the error cases be silent hangs
instead of having some indication of why something went wrong.. I 
wonder if that's what kudzu is doing - shutting the kernel up before
it starts doing things that it should never do.

Anyway, having one

	kudzu: numerical sysctl 1 23 is obsolete.

during bootup seems to be a fairly non-irritating thing, and hopefully the 
kudzu people can just stop doing whatever they are doing.

			Linus

