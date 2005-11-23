Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVKWXgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVKWXgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVKWXgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:36:53 -0500
Received: from xenotime.net ([66.160.160.81]:3735 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751325AbVKWXgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:36:52 -0500
Date: Wed, 23 Nov 2005 15:36:51 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Con Kolivas'" <con@kolivas.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: RE: Kernel BUG at mm/rmap.c:491
In-Reply-To: <200511232333.jANNX9g23967@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0511231535590.20189@shark.he.net>
References: <200511232333.jANNX9g23967@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Chen, Kenneth W wrote:

> Con Kolivas wrote on Wednesday, November 23, 2005 3:24 PM
> > Chen, Kenneth W writes:
> >
> > > Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
> > >
> > > Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
> > >
> > > Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
> >
> >                        ^^^^^^^^^^
> >
> > Please try to reproduce it without proprietary binary modules linked in.
>
>
> ???, I'm not using any modules at all.
>
> [albat]$ /sbin/lsmod
> Module                  Size  Used by
> [albat]$
>
>
> Also, isn't it 'P' indicate proprietary module, not 'G'?

Yes.  It's the 'B' that is tainting in this case:
TAINT_BAD_PAGE is set.

> line 159: kernel/panic.c:
>
>         snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
>                 tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',

-- 
~Randy
