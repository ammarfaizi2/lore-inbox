Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUCAKJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbUCAKJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:09:07 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:30171 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261154AbUCAKI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:08:59 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][7/7] Move debugger_entry()
Date: Mon, 1 Mar 2004 15:38:44 +0530
User-Agent: KMail/1.5
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227215211.GI1052@smtp.west.cox.net> <20040227215428.GJ1052@smtp.west.cox.net>
In-Reply-To: <20040227215428.GJ1052@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011538.44953.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK to checkin.

-Amit

On Saturday 28 Feb 2004 3:24 am, Tom Rini wrote:
> Hello.  When we use kgdboe, we can't use it until do_basic_setup() is done.
> So we have two options, not allow kgdboe to use the initial breakpoint
> or move debugger_entry() to be past the point where kgdboe will be usable.
> I've opted for the latter, as if an earlier breakpoint is needed you can
> still use serial and throw kgdb_schedule_breakpoint/breakpoint where
> desired.
>
> --- linux-2.6.3-rc4/init/main.c	2004-02-17 09:51:19.000000000 -0700
> +++ linux-2.6.3-rc4-kgdb/init/main.c	2004-02-17 11:33:51.854388988 -0700
> @@ -581,6 +582,7 @@ static int init(void * unused)
>
>  	smp_init();
>  	do_basic_setup();
> +	debugger_entry();
>
>  	prepare_namespace();

