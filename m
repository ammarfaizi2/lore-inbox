Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUCJEH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 23:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUCJEHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 23:07:22 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:50333 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261939AbUCJEGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 23:06:13 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Wed, 10 Mar 2004 09:35:54 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
References: <200403081504.30840.amitkale@emsyssoft.com> <200403091459.54161.amitkale@emsyssoft.com> <20040309150632.GH15065@smtp.west.cox.net>
In-Reply-To: <20040309150632.GH15065@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403100935.55417.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 Mar 2004 8:36 pm, Tom Rini wrote:
> On Tue, Mar 09, 2004 at 02:59:54PM +0530, Amit S. Kale wrote:
> [snip]
>
> > I attempted it and found that it works better than my expectation! I am
> > attaching revised core-lite.patch with this email and sending
> > i386-lite.patch as a reply.
>
> [snip]
>
> > Index: linux-2.6.4-rc2-bk3-kgdb/include/linux/kgdb.h
>
> [snip]
>
> > +#ifndef KGDB_MAX_NO_CPUS
> > +#if CONFIG_NR_CPUS > 8
> > +#error KGDB can handle max 8 CPUs
> > +#endif
> > +#define KGDB_MAX_NO_CPUS 8
> > +#endif
>
> We need to remove all of that in favor of s/KGDB_MAX_NO_CPUS/NR_CPUS/g,
> and remove the check on 8.

Yes. I'll do that.
-Amit


