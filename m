Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbSJ3KvB>; Wed, 30 Oct 2002 05:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264667AbSJ3KvA>; Wed, 30 Oct 2002 05:51:00 -0500
Received: from adsl-63-197-69-248.dsl.snfc21.pacbell.net ([63.197.69.248]:29713
	"EHLO ipx.esperanza") by vger.kernel.org with ESMTP
	id <S264665AbSJ3KvA>; Wed, 30 Oct 2002 05:51:00 -0500
Date: Wed, 30 Oct 2002 02:51:06 -0800
From: "Nicolas S. Dade" <ndade@adsl-63-197-69-248.dsl.snfc21.pacbell.net>
To: James Morris <jmorris@intercode.com.au>
Cc: "Nicolas S. Dade" <ndade@adsl-63-197-69-248.dsl.snfc21.pacbell.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.2.22 skb_realloc_headroom()
Message-ID: <20021030025106.A17941@ipx.esperanza>
References: <20021029211945.A17657@ipx.esperanza> <Mutt.LNX.4.44.0210302117420.13753-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Mutt.LNX.4.44.0210302117420.13753-100000@blackbird.intercode.com.au>; from jmorris@intercode.com.au on Wed, Oct 30, 2002 at 09:36:11PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 09:36:11PM +1100, James Morris wrote:
> On Tue, 29 Oct 2002, Nicolas S. Dade wrote:
> 
> > skb_realloc_headroom() panics when new headroom is smaller
> > than existing headroom.
> 
> Would you please test out the patch below?

It works.

It seems a pity to allocate more than needed when
realloc'ing to a smaller headroom; that's why I
used skb->len+headroom as the new length, but
you know this already.

-- 
-- Nicolas Dade    http://nsd.dyndns.org/
