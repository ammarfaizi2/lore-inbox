Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVCNJqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVCNJqC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVCNJqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:46:02 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:33991 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262091AbVCNJpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:45:09 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 14 Mar 2005 10:41:25 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Johannes Stezenbach <js@linuxtv.org>, cherry@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.11 - 2005-03-12.16.00) - 56 New warnings
Message-ID: <20050314094124.GA10276@bytesex>
References: <200503130508.j2D58jTQ014587@ibm-f.pdx.osdl.net> <20050313124333.GA26569@linuxtv.org> <20050313113500.59e57a87.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050313113500.59e57a87.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	struct dvb_pll_desc {
[ ... ]
> >  		struct {
[ ... ]
> >  		} entries[];
> >  	};
> > 
> >  while 2.6.11-mm3 changed it into entries[0].
> 
> The original code failed to compile with gcc-2.95.4, so I stuck the [0] in
> there, then was vaguely surprised when no warnings came out.  Seems that
> later compilers _do_ warn.
> 
> I guess we could put a 9 in there.

Yep, that should do, I think that is enougth for all existing
entries ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
