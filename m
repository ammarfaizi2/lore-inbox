Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWHVURQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWHVURQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWHVURQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:17:16 -0400
Received: from ns.suse.de ([195.135.220.2]:59071 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750981AbWHVURP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:17:15 -0400
To: Zachary Amsden <zach@vmware.com>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain>
	<44DB7596.6010503@goop.org>
	<1156254965.27114.17.camel@localhost.localdomain>
	<200608221544.26989.ak@muc.de> <44EB3BF0.3040805@vmware.com>
	<1156271386.2976.102.camel@laptopd505.fenrus.org>
	<1156275004.27114.34.camel@localhost.localdomain>
	<44EB584A.5070505@vmware.com> <44EB5A76.9060402@vmware.com>
From: Andi Kleen <ak@suse.de>
Date: 22 Aug 2006 22:16:56 +0200
In-Reply-To: <44EB5A76.9060402@vmware.com>
Message-ID: <p73y7tg7cg7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> writes:
> 
> That is a really nasty problem.  You need a synchronization primitive
> which guarantees a flat stack, so you can't do it in the interrupt
> handler as I have tried to do.  I'll bang my head on it awhile.  In
> the meantime, were there ever any solutions to the syscall patching
> problem that might lend me a clue as to what to do (or not to do, or
> impossible?).

stop_machine_run() solves the problem I think. It is currently not 
exported though. I don't think there's anything in there that couldn't
be reimplemented in a module, but then we could also just export it
if there's a useful user.

-Andi
