Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWI3BTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWI3BTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 21:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWI3BTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 21:19:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25506 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932400AbWI3BTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 21:19:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       mj@atrey.karlin.mff.cuni.cz, davej@redhat.com
Subject: Re: [PATCH] x86: update vmlinux.lds.S to place .data section on a page boundary
References: <20060928201249.GA10037@hmsreliant.homelinux.net>
	<20060928204220.GA31096@uranus.ravnborg.org>
	<20060928232206.GA11386@hmsreliant.homelinux.net>
	<20060929000301.GB11386@hmsreliant.homelinux.net>
Date: Fri, 29 Sep 2006 19:13:46 -0600
In-Reply-To: <20060929000301.GB11386@hmsreliant.homelinux.net> (Neil Horman's
	message of "Thu, 28 Sep 2006 20:03:01 -0400")
Message-ID: <m11wpugnqt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman <nhorman@tuxdriver.com> writes:

> Sorry, Replying to myself.  I forgot to mention in my last note why specifically
> I was calling for this change, and why it was necessecary.  In addition to being
> the standard in the script for executable sections, kexec also appears to rely
> on PT_LOAD sections being on page boundaries.  With vmlinux.ld.s as it is, that
> isn't the case, and so we can't load any kernels with kexec at the moment.  I've
> seen this on the most recent fedora kernels (which have the latest version of
> this linker script), and this patch corrects that.
>
> Please look at the file in its entirety, and if you still feel that modifying
> the script so all the ALIGN(4096) directives to be ALIGN(PAGE_SIZE) instead is
> the direction to go, I'll implement the change and test it out.

Is there a reason you don't want to kexec the bzImage?

Eric
