Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbTGJHHb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269047AbTGJHHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:07:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:47260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269030AbTGJHDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:03:52 -0400
Date: Thu, 10 Jul 2003 00:18:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: piet@www.piet.net, schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm3 - apm_save_cpus() Macro still bombs out
Message-Id: <20030710001853.5a3597b7.akpm@osdl.org>
In-Reply-To: <20030710071035.GR15452@holomorphy.com>
References: <20030708223548.791247f5.akpm@osdl.org>
	<200307091106.00781.schlicht@uni-mannheim.de>
	<20030709021849.31eb3aec.akpm@osdl.org>
	<1057815890.22772.19.camel@www.piet.net>
	<20030710060841.GQ15452@holomorphy.com>
	<20030710071035.GR15452@holomorphy.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
>  -#define apm_save_cpus()	0
>  +#define apm_save_cpus()	({ cpumask_t __mask__ = CPU_MASK_NONE; __mask__; })

Taking a look at what the APM code is actually doing, I think using
current->cpus_allowed just more sense in here.

Not that it matters at all.
