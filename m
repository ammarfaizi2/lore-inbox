Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752021AbWHNMjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWHNMjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbWHNMjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:39:15 -0400
Received: from ns.suse.de ([195.135.220.2]:4795 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752021AbWHNMjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:39:14 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH for review] [127/145] i386: move kernel_thread_helper into entry.S
Date: Mon, 14 Aug 2006 14:39:07 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <44E08A76.76E4.0078.0@novell.com>
In-Reply-To: <44E08A76.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608141439.07038.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 14:36, Jan Beulich wrote:
> >> And this too - the value now in %eax has no relation with the
> >> value known by the caller of this routine (which doesn't expect
> >> any return from here anyway).
> >
> >Ok, but somehow it needs to be annotiated so that the unwinder stops
> >and doesn't fall back. Can you please send a replacement patch that 
> >does this correctly? 
> 
> Actually, with the previous attempt we still didn't achieve the
> original
> goal of terminating the frame chain at kernel_thread_helper. Thus
> another try (the seemingly odd extra push can be avoided once we
> start using CFI expressions, which the unwinder currently doesn't
> support):

I added the extra push thanks (hope there weren't more changes)


-Andi
