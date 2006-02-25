Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWBYLHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWBYLHt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWBYLHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:07:49 -0500
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:17623 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030209AbWBYLHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:07:49 -0500
Date: Sat, 25 Feb 2006 06:03:41 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [-mm patch] x86: start early_printk at sensible screen
  row
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, stsp@aknet.ru, ak@suse.de
Message-ID: <200602250607_MC3-1-B93B-782@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060225001533.3b06bbe0.akpm@osdl.org>

On Sat, 25 Feb 2006 at 00:15:33 -0800, Andrew Morton wrote:

> >
> > Use boot info to start early_printk() at the proper row on VGA console.
> > 
> 
> Define "proper".
> 
> > 
> > -           current_ypos = max_ypos;
> > +           current_ypos = SCREEN_INFO.orig_y;
> 
> Is that the place at which the boot loader left the cursor?

Yes, that's what I should have said instead of "proper".

So far I can't break it; after booting with "vga=ask" and doing some
things at the prompt, the kernel output still starts at the right place.

But the emergency fallback early_printk still starts at a fixed place
and the x86_64 'direct mapping' message will screw things up when there's
no earlyprintk boot parameter.

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

