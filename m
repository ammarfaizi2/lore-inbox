Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWAEUXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWAEUXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWAEUXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:23:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932148AbWAEUXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:23:15 -0500
Date: Thu, 5 Jan 2006 12:15:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
cc: Matt Mackall <mpm@selenic.com>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
In-Reply-To: <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org>
 <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org>
 <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org>
 <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org>
 <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Linus Torvalds wrote:
> 
> The cache effects are likely the biggest ones, and no, I don't know how 
> much denser it will be in the cache. Especially with a 64-byte one.. 
> (although 128 bytes is fairly common too).

Oh, but validatign things like "likely()" and "unlikely()" branch hints 
might be a noticeably bigger issue. 

In user space, placement on the macro level is probably a bigger deal, but 
in the kernel we probably care mostly about just single cachelines and 
about branch prediction/placement.

		Linus
