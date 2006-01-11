Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWAKRWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWAKRWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWAKRWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:22:54 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:19209 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751685AbWAKRWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:22:53 -0500
Date: Wed, 11 Jan 2006 18:22:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
Message-ID: <20060111172216.GA18292@mars.ravnborg.org>
References: <adaslrw3zfu.fsf@cisco.com> <1136909276.32183.28.camel@serpentine.pathscale.com> <20060110170722.GA3187@infradead.org> <1136915386.6294.8.camel@serpentine.pathscale.com> <20060110175131.GA5235@infradead.org> <1136915714.6294.10.camel@serpentine.pathscale.com> <20060110140557.41e85f7d.akpm@osdl.org> <1136932162.6294.31.camel@serpentine.pathscale.com> <20060110153257.1aac5370.akpm@osdl.org> <1137000032.11245.11.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137000032.11245.11.camel@camp4.serpentine.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 09:20:32AM -0800, Bryan O'Sullivan wrote:
> On Tue, 2006-01-10 at 15:32 -0800, Andrew Morton wrote:
> 
> > Unless someone can think of a problem with attribute(weak), I think you'll
> > find that it's the simplest-by-far solution.
> 
> The only problem I can see with this is that on x86_64 and other
> platforms that reimplement the routine as an inline function, I think
> we'll be left with a small hunk of dead code in the form of the
> out-of-line version in lib/ that never gets referenced.
If it is not referenced the linker should not pull it in from lib.a -
no?
	Sam
