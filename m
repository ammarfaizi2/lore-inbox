Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWIUNM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWIUNM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 09:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIUNM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 09:12:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6536 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751203AbWIUNM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 09:12:56 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157786802.31071.171.camel@localhost.localdomain> 
References: <1157786802.31071.171.camel@localhost.localdomain>  <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com> <20060908153240.21015.67367.stgit@warthog.cambridge.redhat.com> <20060909051211.GA6922@elte.hu> 
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 2/3] FRV: Permit __do_IRQ() to be dispensed with 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 21 Sep 2006 14:12:14 +0100
Message-ID: <339.1158844334@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> It can't optimize __do_IRQ() out in any case if one uses
> generic_handle_irq() because of the test in there which can't be
> predicted at compile time.

Do you realise that powerpc still uses __do_IRQ if CONFIG_IRQSTACKS=y?  You
should probably fix that.

David
