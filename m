Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUI0NJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUI0NJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 09:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUI0NJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 09:09:43 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:33998 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265805AbUI0NJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 09:09:40 -0400
Date: Mon, 27 Sep 2004 15:09:19 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040927130919.GE28865@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random> <1096272553.6572.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096272553.6572.3.camel@laptop.fenrus.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 10:09:13AM +0200, Arjan van de Ven wrote:
> 
> > I didn't check the topdown model, in theory it should be extended to
> > cover that too, this is only working for the legacy model right now
> > because those apps aren't going to use topdown anyways.
> 
> which "those apps" ?

those apps that wants to allocate as close as possible to the stack.
They're already using /proc/self/mapped_base, the gap of topdown isn't
configurable.

Also topdown may screwup some MAP_FIXED usage below the 1G mark, no?
