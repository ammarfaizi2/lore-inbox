Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSJRCnB>; Thu, 17 Oct 2002 22:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbSJRCnB>; Thu, 17 Oct 2002 22:43:01 -0400
Received: from zero.aec.at ([193.170.194.10]:40207 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262875AbSJRCnB>;
	Thu, 17 Oct 2002 22:43:01 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 still not testable by end users
References: <3DAE2691.76F83D1B@digeo.com>
	<Pine.LNX.4.44.0210171717550.18123-100000@dad.molina>
	<3DAF3C36.2065CFD1@digeo.com>
From: Andi Kleen <ak@muc.de>
Date: 18 Oct 2002 04:48:54 +0200
In-Reply-To: <3DAF3C36.2065CFD1@digeo.com>
Message-ID: <m3smz4o415.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:
> 
> request_irq() needs to take the allocation mode as an argument.
> Should always have.  Sigh.  I'll fix it up sometime.

If you change it I would change it to let the caller pass it in. Then
it's explicit and most drivers can just slab it somewhere in their
private structures without any allocation.

-Andi
