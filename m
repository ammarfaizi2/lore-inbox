Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUCDGc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 01:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUCDGc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 01:32:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:12708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261478AbUCDGc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 01:32:28 -0500
Date: Wed, 3 Mar 2004 22:32:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nmi_watchdog=2 and P4-HT
Message-Id: <20040303223235.177685dd.akpm@osdl.org>
In-Reply-To: <20040304072630.GB683@zaniah>
References: <20040304054215.GA683@zaniah>
	<20040303213033.6348a08b.akpm@osdl.org>
	<20040304072630.GB683@zaniah>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Elie <phil.el@wanadoo.fr> wrote:
>
> 
>  What do you think about the feature "the performance doesn't increment
>  counter in hlt mode".

That sounds OK.  If the CPU halts with local interrupts disabled (is this
possible?) then I assume it'll never come back.  But this possibility isn't
worth worrying about, surely.

Can we scale the performance counter multiplier down a bit?  1000 NMIs per
second sounds excessive.
