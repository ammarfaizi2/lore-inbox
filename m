Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWEaGjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWEaGjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWEaGjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:39:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44239 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964795AbWEaGjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:39:09 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
In-Reply-To: <20060530211442.a260a32e.akpm@osdl.org>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <1149045448.28264.4.camel@localhost.localdomain>
	 <20060530211442.a260a32e.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 31 May 2006 08:39:02 +0200
Message-Id: <1149057543.2725.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 21:14 -0700, Andrew Morton wrote:
> On Tue, 30 May 2006 23:17:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:

> Without having looked at it very hard, I'd venture that this is a false
> positive - that driver uses disable_irq() to prevent reentry onto that
> lock.
> 
> It does that because it knows it's about to spend a long time talking with
> the mii registers and it doesn't want to do that with interrupts disabled.

the scsi controller who shares that irq with your NIC just *enjoys* long
disable_irq() periods.. it can be nice and lazy about it ;)

