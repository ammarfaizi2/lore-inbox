Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbUCSPGe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 10:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbUCSPGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 10:06:34 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:6599 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263013AbUCSPGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 10:06:32 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: module scanning in kgdb 2.x
Date: Fri, 19 Mar 2004 20:36:04 +0530
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Tom Rini <trini@kernel.crashing.org>
References: <200403121206.16130.amitkale@emsyssoft.com> <1079471931.19722.15.camel@bach>
In-Reply-To: <1079471931.19722.15.camel@bach>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403192036.04225.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 Mar 2004 2:48 am, Rusty Russell wrote:
> On Fri, 2004-03-12 at 17:36, Amit S. Kale wrote:
> > Hi,
>
> Hi Amit,
>
> 	FYI: you would have received a quicker response if you'd CC'd me.

Hi Rusty,

Thanks.
Yep! I'll CC you on any further modules stuff.

>
> > It does following things:
> > 1. Adds MODULE_STATE_GONE to indicate that a module was removed. This is
> > differnent from MODULE_STATE_GOING. gdb needs to be notified of a module
> > event _after_ a module has been removed. Or else it'll still find the
> > module during a module list scan and will not remove it from its core.
>
> Makes sense.
>
> > 2. Defines a structure mod_section which stores module section names and
> > offsets preserved during loading of a module.
> >
> > 3. Adds a couple of fields to struct module to keep module section
> > information.
>
> Why not just set the section strings to SHF_ALLOC rather than copying
> (and possibly truncating) the names into your struct mod_section?
> struct mod_section is then simply void *addr; char *name;

How can I do that? Do I have to use objcopy on module files for this purpose?

-Amit
