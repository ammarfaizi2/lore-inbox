Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbWJKOUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWJKOUM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWJKOUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:20:12 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:17808 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030404AbWJKOUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:20:10 -0400
Message-ID: <452CFD98.6010808@drzeus.cx>
Date: Wed, 11 Oct 2006 16:20:08 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Arjan van de Ven <arjan@infradead.org>,
       Amol Lad <amol@verismonetworks.com>,
       kernel Janitors <kernel-janitors@lists.osdl.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: most users of msleep_interruptible are broken
References: <1160570743.19143.307.camel@amol.verismonetworks.com> <1160571491.3000.372.camel@laptopd505.fenrus.org> <20061011141651.GD27388@parisc-linux.org>
In-Reply-To: <20061011141651.GD27388@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> 
> They clearly don't care about exactness; they msleep_interruptible and
> throw away the return value, so they don't know how long they slept
> before they got a signal.
> 

It's broken then. That delay function should delay at least the amount
given.

Rgds
Pierre

