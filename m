Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVCZM3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVCZM3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 07:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVCZM3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 07:29:24 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:11272 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262046AbVCZM3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 07:29:21 -0500
Date: Sat, 26 Mar 2005 13:29:03 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: Linux 2.4.30-rc2
Message-ID: <20050326122903.GB14756@alpha.home.local>
References: <20050326004631.GC17637@logos.cnet> <20050326113426.GO30052@alpha.home.local> <1111837579.8042.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111837579.8042.5.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 12:46:19PM +0100, Arjan van de Ven wrote:
> On Sat, 2005-03-26 at 12:34 +0100, Willy Tarreau wrote:
> > Marcelo,
> > 
> > just another one and that's all. Zachary Amsden found an unconditional
> > write to a debug register in the signal delivery path which is only
> > needed when we use a breakpoint. This is a very expensive operation on
> > x86, and doing it conditionnaly enhanced signal delivery speed by 33%
> > for him.
> 
> this sounds rather risky for this late in the game; heck it sounds risky
> in 2.4 period. This code changed a lot in 2.6 so just a plain backport
> is by no means risk free, while the effect of a wrong debug register can
> even have security impact. 

ok, that's a good reason.

Willy

