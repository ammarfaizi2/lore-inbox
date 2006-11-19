Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756809AbWKSUT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809AbWKSUT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756819AbWKSUT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:19:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:26858 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1756809AbWKSUTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:19:55 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <20061119200650.GA22949@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	 <1163966437.5826.99.camel@localhost.localdomain>
	 <20061119200650.GA22949@elte.hu>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:19:50 +1100
Message-Id: <1163967590.5826.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 21:06 +0100, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Wait wait wait .... Can somebody (Ingo ?) explain me why the fasteoi 
> > handler is being changed and what is the rationale for adding an ack 
> > that was not necessary before ?
> 
> dont worry, it's -rt only stuff.

Still, I'm curious :-) Besides, there have been people talking about
having -rt work on ppc64 so ...

What do you need an ack() for on fasteoi ? On all fasteoi controllers I
have, ack is implicit by obtaining the vector number and all there is is
an eoi...

Cheers,
Ben.


