Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVEHOyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVEHOyE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 10:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVEHOyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 10:54:04 -0400
Received: from colin.muc.de ([193.149.48.1]:27910 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262878AbVEHOyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 10:54:01 -0400
Date: 8 May 2005 16:53:56 +0200
Date: Sun, 8 May 2005 16:53:56 +0200
From: Andi Kleen <ak@muc.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: vatsa@in.ibm.com, schwidefsky@de.ibm.com, jdike@addtoit.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050508145356.GB21873@muc.de>
References: <20050507182728.GA29592@in.ibm.com> <1115524211.17482.23.camel@localhost.localdomain> <1115547230.5998.10.camel@laptopd505.fenrus.org> <m1oeblvo3x.fsf@muc.de> <1115559855.5998.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115559855.5998.26.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 03:44:14PM +0200, Arjan van de Ven wrote:
> 
> > But it has to be *really* lightweight because these transistion can
> > happen a lot (consider a CPU that very often goes to sleep for a short time)
> 
> lightweight is good of course. But even if it's medium weight.. it just
> means you need to be REALLY idle (eg for longer time) for it to trigger.
> I guess we need some sort of per arch "idleness threshhold" for this.

The question is how useful it is for the hypervisor to even know that.
Why can't it just detect long idle periods by itself if it really wants?

-Andi
