Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWEKS2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWEKS2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWEKS2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:28:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:30153 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750789AbWEKS2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:28:25 -0400
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, kraxel@suse.de
Subject: Re: [patch] SMP alternatives: skip with UP kernels.
References: <200605111622.k4BGMAUn003662@harpo.it.uu.se>
From: Andi Kleen <ak@suse.de>
Date: 11 May 2006 20:28:09 +0200
In-Reply-To: <200605111622.k4BGMAUn003662@harpo.it.uu.se>
Message-ID: <p73hd3w76x2.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@it.uu.se> writes:

> On Thu, 11 May 2006 14:13:22 +0200, Gerd Hoffmann wrote:
> >+	if (0 == (__smp_alt_end - __smp_alt_begin))
> >+		return; /* no tables, nothing to patch (UP kernel) */
> 
> That's an unnecessarily obscure way of stating the obvious:
> 
> 	if (__smp_alt_end == __smp_alt_begin)

iirc ISO-C guarantees that symbols have different values and the
optimizer could possibly make use of that fact. So you might actually
need some RELOC_HIDE()s to make this safe.

-Andi

