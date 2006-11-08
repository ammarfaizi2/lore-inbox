Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422875AbWKHUbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422875AbWKHUbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423177AbWKHUbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:31:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422875AbWKHUbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:31:31 -0500
Date: Wed, 8 Nov 2006 12:31:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Reuben Farrelly <reuben-linuxkernel@reub.net>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.19-rc5-mm1
Message-Id: <20061108123110.74dcb6e3.akpm@osdl.org>
In-Reply-To: <20061108201539.GB32721@redhat.com>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<4551BB5E.6090602@reub.net>
	<20061108120547.78048229.akpm@osdl.org>
	<20061108201539.GB32721@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 15:15:39 -0500
Dave Jones <davej@redhat.com> wrote:

> On Wed, Nov 08, 2006 at 12:05:47PM -0800, Andrew Morton wrote:
> 
>  > The problem is that you have 
>  > 
>  > > CONFIG_CPU_FREQ_TABLE=m
>  > > CONFIG_X86_ACPI_CPUFREQ=y
>  > 
>  > but acpi-cpufreq needs the stuff in freq_table.c.
>  > 
>  > This happens again and again and again and again.  I wish people would just
>  > stop using `select'.  It.  Doesn't.  Work.
>  > 
>  > Either we fix select or we stop using the damn thing.
> 
> So, why doesn't select set the symbol it's selecting to the
> same value as the symbol being configured ?

It would have to be "same or higher", where y > m

> That would solve the issue no?

It would sort-of-solve this issue.  But it wouldn't stop `select' from being a
pita.  I spent some time trying to reverse-engineer Reuben's config from
the tiny bit he shared with us and gave up because a twisty maze of selects
kept on insisting that CONFIG_CPU_FREQ_TABLE=y.
