Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265135AbUFARJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbUFARJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 13:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbUFARJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 13:09:16 -0400
Received: from ozlabs.org ([203.10.76.45]:23207 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265128AbUFARJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 13:09:13 -0400
Date: Wed, 2 Jun 2004 03:04:18 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       arnd@arndb.de
Subject: Re: compat syscall args
Message-ID: <20040601170418.GA4239@krispykreme>
References: <21hGW-h5-5@gated-at.bofh.it> <229Hi-B1-11@gated-at.bofh.it> <22drH-3Bc-47@gated-at.bofh.it> <22dL7-3O8-39@gated-at.bofh.it> <m38yf7juj6.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m38yf7juj6.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> It would be better to do this consistently over all architectures
> and do the sign extension (which is much less common than zero
> extension) always in C code. Then when someone adds a new compat
> handler the chances are high that it will just work over multiple
> architectures (ok minus s390) without much more changes. 

On ppc64 we now zero extend all arguments. I too would like to see the
sign extension done in the common compat code, at the moment we have to
be careful to do it before calling compat code.

Anton
