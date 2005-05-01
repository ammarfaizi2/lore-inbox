Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVEARqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVEARqC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 13:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVEARqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 13:46:02 -0400
Received: from s-utl01-lapop.stsn.com ([12.129.240.11]:8206 "HELO
	s-utl01-lapop.stsn.com") by vger.kernel.org with SMTP
	id S262627AbVEARp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 13:45:57 -0400
Subject: Re: [PATCH] hangcheck-timer: Update to 0.9.0.
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: joel.becker@oracle.com
In-Reply-To: <200505011707.j41H7VbY021843@hera.kernel.org>
References: <200505011707.j41H7VbY021843@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 01 May 2005 13:45:37 -0400
Message-Id: <1114969538.6577.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
> +# define HAVE_MONOTONIC
> +# define TIMER_FREQ 1000000000ULL

this looks wrong!

does this work with HZ=100 ?
also there is a TSC config option which you want to use most likely
instead of CONFIG_X86 (and x86-64 has CONFIG_X86 defined too)




