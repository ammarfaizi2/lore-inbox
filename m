Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUEPMoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUEPMoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 08:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbUEPMoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 08:44:20 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:62634 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263555AbUEPMoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 08:44:17 -0400
Date: Sun, 16 May 2004 16:44:20 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Christoph Hellwig <hch@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>
Subject: Re: alpha fp-emu vs module refcounting
Message-ID: <20040516164420.A950@den.park.msu.ru>
References: <20040507110217.GA11366@lst.de> <20040507183208.A3283@jurassic.park.msu.ru> <20040507143512.GA14338@lst.de> <20040508023717.A3960@jurassic.park.msu.ru> <20040507224104.GA21153@lst.de> <20040508025142.A4330@jurassic.park.msu.ru> <20040516100435.GD16301@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040516100435.GD16301@infradead.org>; from hch@lst.de on Sun, May 16, 2004 at 12:04:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 12:04:35PM +0200, Christoph Hellwig wrote:
> Well, still false positives in grep.  What about this patch to simply
> remove any traces of CONFIG_MATHEMU and modular math emulation?

Personally, I'm fine with it.

Yet another simple solution would be just to remove refcounting and
only allow modular build of math-emu when CONFIG_SMP=n, which is
safe vs module unload and still fine for debugging.

Richard?

Ivan.
