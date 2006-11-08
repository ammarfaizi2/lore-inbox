Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965472AbWKHKbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472AbWKHKbh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965548AbWKHKbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:31:36 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56547 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965515AbWKHKbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:31:35 -0500
Message-ID: <4551B1ED.2000405@sgi.com>
Date: Wed, 08 Nov 2006 11:31:09 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: =?ISO-8859-1?Q?Fernando_Luis_V=E1zquez_Cao?= 
	<fernando@oss.ntt.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Robin Holt <holt@sgi.com>, Dean Nelson <dcn@sgi.com>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 0/1] mspec driver: compile error
References: <1162881017.13700.105.camel@sebastian.intellilink.co.jp>	<4550609A.7010908@sgi.com>	<20061107133512.a49b11e0.akpm@osdl.org>	<1162977589.7805.77.camel@sebastian.intellilink.co.jp>	<4551A66A.2070506@sgi.com>	<1162979130.7805.80.camel@sebastian.intellilink.co.jp> <20061108015618.571242fb.akpm@osdl.org>
In-Reply-To: <20061108015618.571242fb.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 08 Nov 2006 18:45:30 +0900
> Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp> wrote:
>> On Wed, 2006-11-08 at 10:42 +0100, Jes Sorensen wrote:
>>> Given that MSPEC is clearly marked as depending on IA64, it seems bogus
>>> for i386 allmodconfig to barf over it and the problem should be fixed
>>> there instead IMHO.
>> Agreed. That is why I asked if that was allmodconfig's expected
>> behaviour. Andrew?
> 
> kconfig's `select' isn't very smart.  This is one of the reasons why one
> should avoid using it.

Hmmm, so what do we do? I really don't like the idea that one has to
manually select the uncached allocator in order for mspec to be
available.

Alternatively can move the Kconfig field for MSPEC to arch/ia64/Kconfig,
but that seems a bit dodgy too.

Cheers,
Jes
