Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266021AbUGELJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUGELJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 07:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUGELJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 07:09:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6324 "EHLO scrub.home")
	by vger.kernel.org with ESMTP id S266021AbUGELI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 07:08:26 -0400
Date: Mon, 5 Jul 2004 13:01:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: karim@opersys.com, peterm@redhat.com, faith@redhat.com, davidm@hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       ray.lanza@hp.com, trz@us.ibm.com, richardj_moore@uk.ibm.com,
       bob@watson.ibm.com, michel.dagenais@polymtl.ca
Subject: Re: [PATCH] IA64 audit support
In-Reply-To: <20040701231844.0aed5201.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0407051211410.5033@scrub.home>
References: <200406301556.i5UFuGg8009251@redrum.boston.redhat.com>
 <20040701124644.5e301ca0.akpm@osdl.org> <40E4B20F.8010503@opersys.com>
 <20040701182954.43351d36.akpm@osdl.org> <40E4D4AD.2020302@opersys.com>
 <20040701231844.0aed5201.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Jul 2004, Andrew Morton wrote:

> > This is probably one of the biggest misconception about LTT amongst kernel
> > developers. So let me present this once more: LTT is _NOT_ for kernel
> > developers, it has never been developed with this crowd in mind. LTT is and
> > has _ALWAYS_ been intended for the end user.
> 
> Note I said "developer", not "kernel developer".  If the audience for a
> feature is kernel developers, userspace developers and perhaps the most
> sophisticated sysadmins then that's a small audience.  It's certainly an
> _important_ audience, but the feature is not as important as those
> codepaths which Uncle Tillie needs to run his applications.

And if one this applications misbehaves, he might want to know what is 
actually going wrong. A tracing mechanism could tell him e.g. why xmms 
sometimes stops and with the right visualization tools even an user with 
basic technical knowledge could give some more precise feedback. You 
wouldn't just get reports with "if I do X, the system feels weird".

I'd really like to see some tracing infrastructure in the kernel, as it's 
also a very useful tool during kernel development, when trying to find 
some weird problems or finding perfomance bottlenecks, where printk or 
kgdb isn't much help.

> > The issues about the spread of trace points across the source code are
> > exactly the same, you still need to mark the code-paths (and maintain
> > these markings for each version) regardless of the mechanism being used.
> 
> Nope, kprobes allows a kernel module to patch hooks into the running
> binary.  That's all it does, really.   See
> http://www-124.ibm.com/linux/projects/kprobes/

kprobes are a nice option, but it would be a nightmare (especially 
regarding portability) if any project had to rely on them.
kprobes are already very complex conceptually, it may be a requirement to 
debug a binary kernel, but otherwise some simple hooks are preferable.

bye, Roman
