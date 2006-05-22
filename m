Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWEWABM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWEWABM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 20:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWEWABM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 20:01:12 -0400
Received: from ns1.suse.de ([195.135.220.2]:51598 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751319AbWEWABL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 20:01:11 -0400
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@sgi.com>
Subject: Re: NMI problems with Dell SMP Xeons
Date: Tue, 23 May 2006 01:56:39 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <12475.1148288884@kao2.melbourne.sgi.com>
In-Reply-To: <12475.1148288884@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605230156.40149.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (1) IPI 2, not marked as NMI.  This does _not_ call into the do_nmi()
>     routine.
> 
>     People have been telling me (hi, Andi:) that sending interrupt 2 as
>     an IPI automatically sends it as an NMI. 

I can't remember ever saying that. I said that sending anything with the 
NMI bit set will end up at the NMI vector, not the original vector
you specified. Or at least that is what the Intel manual specify.
That is why it is useless to hook the original vector like you did
and add special cases just to get an NMI send with different vector.

-Andi



