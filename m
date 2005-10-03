Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVJCNA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVJCNA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 09:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVJCNA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 09:00:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:783 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932172AbVJCNA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 09:00:56 -0400
Date: Mon, 3 Oct 2005 14:00:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
Message-ID: <20051003130048.GE16717@flint.arm.linux.org.uk>
Mail-Followup-To: Pekka J Enberg <penberg@cs.Helsinki.FI>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <20051002170318.GA22074@home.fluff.org> <20051002103922.34dd287d.rdunlap@xenotime.net> <20051003094803.GC3500@home.fluff.org> <9a8748490510030259o43646cbbo22b37f1791d267e@mail.gmail.com> <20051003100431.GA16717@flint.arm.linux.org.uk> <84144f020510030543q10ff4fd2g138de4d06eddc440@mail.gmail.com> <20051003124950.GD16717@flint.arm.linux.org.uk> <Pine.LNX.4.58.0510031552450.24263@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510031552450.24263@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 03:54:31PM +0300, Pekka J Enberg wrote:
> On Mon, 3 Oct 2005, Russell King wrote:
> > On the other hand, release_region() is the counter-part of
> > request_region() and should be used to release resources
> > created by request_region().
> 
> Right. To me, it makes sense for the release counter-part accept NULL if 
> the allocation/initialization function can return it.

Right.  Which it already can (with a complaint).

However, I think you missed my point though.  release_resource() is
_not_ the counterpart of request_region().  It's the counter-part of
request_resource() which does not allocate any memory itself.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
