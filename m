Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWHGCHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWHGCHA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWHGCHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:07:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40168 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750886AbWHGCG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:06:59 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
Date: Mon, 7 Aug 2006 04:06:45 +0200
User-Agent: KMail/1.9.3
Cc: Hugh Dickins <hugh@veritas.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com> <20060806121530.eac1dd37.akpm@osdl.org>
In-Reply-To: <20060806121530.eac1dd37.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070406.45359.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 August 2006 21:15, Andrew Morton wrote:
> On Sun, 6 Aug 2006 18:22:04 +0100 (BST)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> > I was impressed by how fast 2.6.18-rc3-mm2 is under memory pressure,
> > until I noticed that my "mem=512M" boot option was doing nothing.  The
> > two fixes below got it working, but I wonder how many other early_param
> > "option=" args are wrong (e.g. "memmap=" in the same file): x86_64
> > shows many such, i386 shows only one, I've not followed it up further.
> 
> Thanks again.
> 
> Andi, it sounds like so many fixes will be needed there that it's worth
> dropping, pending rev #2.

Yes, it looks like it. Now I remember why I dropped this a long time
ago already ;-)

After fixing Hugh's issue with all parameters
(there were some more with this) the kernel goes into an endless loop
at boot when you have one which is a full prefix of another.

-Andi
