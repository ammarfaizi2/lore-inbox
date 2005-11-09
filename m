Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVKIQuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVKIQuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVKIQuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:50:21 -0500
Received: from xenotime.net ([66.160.160.81]:53163 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932079AbVKIQuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:50:19 -0500
Date: Wed, 9 Nov 2005 08:50:15 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jan Beulich <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/39] NLKD - an alternative kallsyms approach
In-Reply-To: <43720E2E.76F0.0078.0@novell.com>
Message-ID: <Pine.LNX.4.58.0511090847590.4001@shark.he.net>
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Jan Beulich wrote:

> This patch provides an alternative to the pre-exisiting kallsyms code.
> That code, from a kernel debugger perspective at least, suffers from
> incomplete information, making it impossible to
> (a) disambiguate multiple static functions of the same name (in
> different source files),
> (b) determine a complete set of attributes for a symbol (namely, the
> symbol's size, but also its type, which gets converted to an nm-like
> one-character representation), and
> (c) retain full section information
>
> This new approach basically makes handling core kernel and module
> symbols the same, by retrieving the kernel's section, symbol, and
> string tables rather than parsing the system map.
>
> At once it adds the functionality to strip unneeded symbols from
> modules, which results in non-neglectable space savings for typical
> distributions (which large amounts of modules). Note that with certain
> recent, but broken binutils versions (2.16.90*, 2.16.91* up to
> and including 2.16.91.0.3) this can only be built without
> CONFIG_MODVERSIONS.
>
> Signed-Off-By: Jan Beulich <jbeulich@novell.com>
>
> (actual patch attached)

It's still not a text-type attachment...

BTW, are you posting these just for comments or did you want
someone to apply/merge them?  If so, who?  You should send them
to that someone (unless you have some other arrangements) --
at least that's the normal procedure.

-- 
~Randy
