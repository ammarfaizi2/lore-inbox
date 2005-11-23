Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbVKWXja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbVKWXja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbVKWXj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:39:29 -0500
Received: from xenotime.net ([66.160.160.81]:37785 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030504AbVKWXjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:39:16 -0500
Date: Wed, 23 Nov 2005 15:39:14 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Con Kolivas'" <con@kolivas.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: RE: Kernel BUG at mm/rmap.c:491
In-Reply-To: <Pine.LNX.4.58.0511231535590.20189@shark.he.net>
Message-ID: <Pine.LNX.4.58.0511231538470.20189@shark.he.net>
References: <200511232333.jANNX9g23967@unix-os.sc.intel.com>
 <Pine.LNX.4.58.0511231535590.20189@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Randy.Dunlap wrote:

> On Wed, 23 Nov 2005, Chen, Kenneth W wrote:
>
> > Con Kolivas wrote on Wednesday, November 23, 2005 3:24 PM
> > > Chen, Kenneth W writes:
> > >
> > > > Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
> > > >
> > > > Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
> > > >
> > > > Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
> > >
> > >                        ^^^^^^^^^^
> > >
> > > Please try to reproduce it without proprietary binary modules linked in.
> >
> >
> > ???, I'm not using any modules at all.
> >
> > [albat]$ /sbin/lsmod
> > Module                  Size  Used by
> > [albat]$
> >
> >
> > Also, isn't it 'P' indicate proprietary module, not 'G'?
>
> Yes.  It's the 'B' that is tainting in this case:
> TAINT_BAD_PAGE is set.

in only one place:
./mm/page_alloc.c:148:  add_taint(TAINT_BAD_PAGE);


> > line 159: kernel/panic.c:
> >
> >         snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
> >                 tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
>
>

-- 
~Randy
