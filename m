Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVATRtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVATRtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVATRty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:49:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:58266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261298AbVATRtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:49:00 -0500
Date: Thu, 20 Jan 2005 09:48:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: Re: [patch 1/3] spinlock fix #1, *_can_lock() primitives
In-Reply-To: <20050120164038.GA15874@elte.hu>
Message-ID: <Pine.LNX.4.58.0501200947440.8178@ppc970.osdl.org>
References: <16878.9678.73202.771962@wombat.chubb.wattle.id.au>
 <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com>
 <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org>
 <20050120031854.GA8538@taniwha.stupidest.org> <16879.29449.734172.893834@wombat.chubb.wattle.id.au>
 <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org> <20050120160839.GA13067@elte.hu>
 <Pine.LNX.4.58.0501200823010.8178@ppc970.osdl.org> <20050120164038.GA15874@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jan 2005, Ingo Molnar wrote:
> 
> You are right about UP, and the patch below adds the UP variants. It's
> analogous to the existing wrapping concept that UP 'spinlocks' are
> always unlocked on UP. (spin_can_lock() is already properly defined on
> UP too.)

Looking closer, it _looks_ like the spinlock debug case never had a 
"spin_is_locked()" define at all. Or am I blind? Maybe UP doesn't 
want/need it after all?

		Linus
