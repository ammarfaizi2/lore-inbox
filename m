Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263593AbUEPNJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUEPNJp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 09:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUEPNJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 09:09:45 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:14865 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263593AbUEPNJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 09:09:43 -0400
Date: Sun, 16 May 2004 14:09:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Subject: Re: alpha fp-emu vs module refcounting
Message-ID: <20040516140940.A16850@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>
References: <20040507110217.GA11366@lst.de> <20040507183208.A3283@jurassic.park.msu.ru> <20040507143512.GA14338@lst.de> <20040508023717.A3960@jurassic.park.msu.ru> <20040507224104.GA21153@lst.de> <20040508025142.A4330@jurassic.park.msu.ru> <20040516100435.GD16301@infradead.org> <20040516164420.A950@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040516164420.A950@den.park.msu.ru>; from ink@jurassic.park.msu.ru on Sun, May 16, 2004 at 04:44:20PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 04:44:20PM +0400, Ivan Kokshaysky wrote:
> On Sun, May 16, 2004 at 12:04:35PM +0200, Christoph Hellwig wrote:
> > Well, still false positives in grep.  What about this patch to simply
> > remove any traces of CONFIG_MATHEMU and modular math emulation?
> 
> Personally, I'm fine with it.
> 
> Yet another simple solution would be just to remove refcounting and
> only allow modular build of math-emu when CONFIG_SMP=n, which is
> safe vs module unload and still fine for debugging.

UP is not safe vs module unloading per se.  Especially not with
CONFIG_PREEMPT.  I'd say just apply the patch and if someone badly needs
modular mathemu for debugging he/she can apply some local hack.

