Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVD2Am4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVD2Am4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 20:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVD2Am4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 20:42:56 -0400
Received: from pat.uio.no ([129.240.130.16]:10903 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262206AbVD2Amu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 20:42:50 -0400
Subject: Re: [RFC] unify semaphore implementations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050428234005.A19778@flint.arm.linux.org.uk>
References: <20050428182926.GC16545@kvack.org>
	 <20050428234005.A19778@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 20:42:38 -0400
Message-Id: <1114735358.9738.36.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.705, required 12,
	autolearn=disabled, AWL 1.29, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 28.04.2005 Klokka 23:40 (+0100) skreiv Russell King:
> On Thu, Apr 28, 2005 at 02:29:26PM -0400, Benjamin LaHaise wrote:
> > Please review the following series of patches for unifying the 
> > semaphore implementation across all architectures (not posted as 
> > they're about 350K), as they have only been tested on x86-64.  The 
> > code generated is functionally identical to the earlier i386 
> > variant, but since gcc has no way of taking condition codes as 
> > results, there are two additional instructions inserted from the 
> > use of generic atomic operations.  All told the >6000 lines of code 
> > deleted makes for a much easier job for subsequent patches changing 
> > semaphore functionality.  Cheers,
> 
> I'm not sure why we're doing this, apart from a desire to unify stuff.

It started from a desire to extend the existing implementations to
support new features such as asynchronous notification. Currently that
sort of thing is impossible unless your developer-super-powers include
the ability to herd 24 different subsystem maintainers into working
together on a solution.

In other words, the main drive is the desire to make it maintainable.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

