Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVKLVJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVKLVJE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVKLVJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:09:04 -0500
Received: from xenotime.net ([66.160.160.81]:58563 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964810AbVKLVJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:09:03 -0500
Date: Sat, 12 Nov 2005 12:52:29 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/39] NLKD - early/late CPU up/down notification
Message-Id: <20051112125229.1c53f23c.rdunlap@xenotime.net>
In-Reply-To: <43745BD6.76F0.0078.0@novell.com>
References: <43720DAE.76F0.0078.0@novell.com>
	<43720E2E.76F0.0078.0@novell.com>
	<43720E72.76F0.0078.0@novell.com>
	<43720EAF.76F0.0078.0@novell.com>
	<20051109164544.GB32068@kroah.com>
	<43723B57.76F0.0078.0@novell.com>
	<20051109171919.GA32761@kroah.com>
	<437307BC.76F0.0078.0@novell.com>
	<20051110205931.GC7584@mars.ravnborg.org>
	<43745BD6.76F0.0078.0@novell.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005 08:52:38 +0100 Jan Beulich wrote:

> >>> Sam Ravnborg <sam@ravnborg.org> 10.11.05 21:59:31 >>>
> >> I understand that. But you don't see my point, so I'll try to
> explain
> >> the background: When discovering the reason for the kallsyms change
> >> (also posted with the other NLKD patches) not functioning with
> >> CONFIG_MODVERSIONS and binutils between 2.16.90 and 2.16.91.0.3 I
> >> realized that the warning messages from the modpost build stage are
> very
> >> easy to overlook (in fact, all reporters of the problem overlooked
> them
> >> as well as I did on the first build attempting to reproduce the
> >> problem). This basically means these messages are almost useless,
> and
> >> detection of the problem will likely be deferred to the first
> attempt to
> >> load an offending module (which, as in the case named, may lead to
> an
> >> unusable kernel). Hence, at least until this build problem gets
> >> addressed I continue to believe that adding the preprocessor
> conditional
> >> is the better way of dealing with potential issues.
> >
> >Can you elaborate a little what you like to have done to the build
> >process.
> 
> As said above, I'd like to see the messages from modpost deferred or
> re-issued at the end of the module building process (i.e. after the
> perhaps hundreds of *.mod.c files got compiled and the same number of
> *.ko got linked, which on a typical distribution will easily scroll off
> the original warnings even with a 1000 line history, as seems to be the
> default in many cases).

Lots of such error or warning messages scroll away.  All that it takes
is use of egrep "foo|bar" to look for the interesting messages
or egrep -v "foo|bar" to discard the uninteresting (normal) messages.
I do that all the time and I think that it's the right thing to do,
not have the tools regurgitate something that they have already said.

---
~Randy
