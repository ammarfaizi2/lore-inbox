Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVCIUBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVCIUBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVCIUAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:00:14 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:61062 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261733AbVCITwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:52:44 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 1/1] unified spinlock initialization arch/um/drivers/port_kern.c
Date: Wed, 9 Mar 2005 20:52:24 +0100
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org,
       amitg@calsoftinc.com, gud@eth.net
References: <20050309094234.8FC0C6477@zion> <20050309171231.H25398@flint.arm.linux.org.uk>
In-Reply-To: <20050309171231.H25398@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503092052.24803.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 18:12, Russell King wrote:
> On Wed, Mar 09, 2005 at 10:42:33AM +0100, blaisorblade@yahoo.it wrote:
> > From: <domen@coderock.org>
> > Cc: <user-mode-linux-devel@lists.sourceforge.net>, <domen@coderock.org>,
> > <amitg@calsoftinc.com>, <gud@eth.net>
> >
> > Unify the spinlock initialization as far as possible.

> Are you sure this is really the best option in this instance?
> Sometimes, static data initialisation is more efficient than
> code-based manual initialisation, especially when the memory
> is written to anyway.
Agreed, theoretically, but this was done for multiple reasons globally, for 
instance as a preparation to Ingo Molnar's preemption patches. There was 
mention of this on lwn.net about this:

http://lwn.net/Articles/108719/

Ok?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

