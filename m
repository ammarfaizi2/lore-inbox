Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVCIMAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVCIMAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 07:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVCIMAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 07:00:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23458 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262300AbVCIMAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 07:00:04 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050309032832.159e58a4.akpm@osdl.org> 
References: <20050309032832.159e58a4.akpm@osdl.org>  <20050308170107.231a145c.akpm@osdl.org> <1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com> <18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com> <1110366469.6280.84.camel@laptopd505.fenrus.org> 
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, suparna@in.ibm.com,
       pbadari@us.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: aio stress panic on 2.6.11-mm1 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 09 Mar 2005 11:59:20 +0000
Message-ID: <3318.1110369560@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> spin_lock_irq() is OK for down_*(), since down() can call schedule() anyway.
> 
> spin_lock_irqsave() should be used in up_*() and I guess down_*_trylock(),
> although the latter shouldn't need to go into the slowpath anyway.

That's what I've done. I'm just testing my changes.

David
