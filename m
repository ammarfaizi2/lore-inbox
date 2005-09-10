Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVIJOpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVIJOpF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 10:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVIJOpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 10:45:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23006 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750981AbVIJOpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 10:45:03 -0400
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [2/2] Change p[gum]d_clear_* inlines to macros to fix p?d_ERROR
Date: Sat, 10 Sep 2005 16:44:55 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <4322CBD9.mailE1P118OD2@suse.de> <Pine.LNX.4.61.0509101440420.14979@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509101440420.14979@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509101644.55887.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 September 2005 16:15, Hugh Dickins wrote:
> On Sat, 10 Sep 2005, Andi Kleen wrote:
> > Change p[gum]d_clear_* inlines to macros to fix p?d_ERROR
> >
> > When this code was refactored by Hugh it was moved out of the actual
> > functions into these inlines. The problem is that pgd_ERROR
> > uses __FUNCTION__ and __LINE__ to show where the error happened,
> > and with the inline that is pretty meaningless now because
> > it's the same for all callers.
> >
> > Change them to be macros to avoid this problem
>
> Please don't.  It adds much less than I misremember (only 550 bytes
> to my i386 PAE config), but even so it's a waste of space. 

Hmm? Macros and inlines take the same amount of space. 


>
> (Of course, I was emboldened to make those changes because the messages
> had never been seen in living memory, beyond our own private development
> screwups.  They started appearing just around the time I changed them.)

I have actually seen them while debugging something. But it was useless. That 
is why I made the change.

-Andi
