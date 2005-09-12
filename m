Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVILTya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVILTya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVILTya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:54:30 -0400
Received: from xenotime.net ([66.160.160.81]:29390 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932177AbVILTy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:54:29 -0400
Date: Mon, 12 Sep 2005 12:54:27 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Hugh Dickins <hugh@veritas.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: Tainted lsmod output
In-Reply-To: <Pine.LNX.4.61.0509122039350.5019@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.50.0509121253300.30198-100000@shark.he.net>
References: <4325C713.6060908@latinsourcetech.com>
 <Pine.LNX.4.50.0509121129470.30198-100000@shark.he.net>
 <Pine.LNX.4.61.0509122039350.5019@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2005, Hugh Dickins wrote:

> On Mon, 12 Sep 2005, Randy.Dunlap wrote:
> >
> >  *  'P' - Proprietary module has been loaded.
> >  *  'F' - Module has been forcibly loaded.
> >  *  'S' - SMP with CPUs not designed for SMP.
> >  *  'R' - User forced a module unload.
> >  *  'M' - Machine had a machine check experience.
> >  *  'B' - System has hit bad_page.
>
> The one that puzzles me greatly isn't listed there: 'G'

I guess it means GPL.

It's just the opposite of 'P', whereas all of the others
have opposites of ' '.

		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
			tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ',
			tainted & TAINT_FORCED_RMMOD ? 'R' : ' ',
 			tainted & TAINT_MACHINE_CHECK ? 'M' : ' ',
			tainted & TAINT_BAD_PAGE ? 'B' : ' ');

-- 
~Randy
