Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSKXWef>; Sun, 24 Nov 2002 17:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSKXWef>; Sun, 24 Nov 2002 17:34:35 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:8711
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261855AbSKXWee>; Sun, 24 Nov 2002 17:34:34 -0500
Subject: Re: calling schedule() from interupt context
From: Robert Love <rml@tech9.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
In-Reply-To: <20021124223234.7C5EB2C111@lists.samba.org>
References: <20021124223234.7C5EB2C111@lists.samba.org>
Content-Type: text/plain
Organization: 
Message-Id: <1038177703.777.62.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 24 Nov 2002 17:41:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-24 at 16:42, Rusty Russell wrote:

> > Oh we can't kill module references from interrupts?
> 
> Err, no, that would be insane.  get_cpu() & put_cpu() should work
> perfectly fine inside interrupts, no?

Yes, they do.

Since the preempt_count is bumped on entry to the interrupt handler, it
is always at least one, and thus put_cpu() will never call schedule.

	Robert Love

