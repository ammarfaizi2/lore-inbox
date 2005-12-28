Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVL1Ojw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVL1Ojw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVL1Ojw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:39:52 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:58438 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S964824AbVL1Ojv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:39:51 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 01/2] allow gcc4 to control inlining
X-Message-Flag: Warning: May contain useful information
References: <20051228114653.GB3003@elte.hu>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 28 Dec 2005 06:39:39 -0800
In-Reply-To: <20051228114653.GB3003@elte.hu> (Ingo Molnar's message of "Wed,
 28 Dec 2005 12:46:53 +0100")
Message-ID: <adak6dpcml0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Dec 2005 14:39:49.0115 (UTC) FILETIME=[8E05F4B0:01C60BBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > -#define inline			inline		__attribute__((always_inline))
 > -#define __inline__		__inline__	__attribute__((always_inline))
 > -#define __inline		__inline	__attribute__((always_inline))

Why not just delete these lines?  This:

 > +#define inline			inline
 > +#define __inline__		__inline__
 > +#define __inline		__inline

seems pointless to me.

 - R.
