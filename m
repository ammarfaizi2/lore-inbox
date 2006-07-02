Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWGBS1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWGBS1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWGBS1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:27:25 -0400
Received: from xenotime.net ([66.160.160.81]:4587 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964874AbWGBS1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:27:25 -0400
Date: Sun, 2 Jul 2006 11:30:10 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org, akpm@osdl.org
Subject: Re: 2.6.17: Yet another .config that won't build
Message-Id: <20060702113010.021800f7.rdunlap@xenotime.net>
In-Reply-To: <200606230954_MC3-1-C33F-7BD7@compuserve.com>
References: <200606230954_MC3-1-C33F-7BD7@compuserve.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 09:53:05 -0400 Chuck Ebbert wrote:

> On i386, selecting SMP, HIGHMEM64G and X86_GENERICARCH enables NUMA.

I don't see NUMA being enabled by SMP + HIGHMEM64G + X86_GENERICARCH
(on 2.6.17-git20).  Has this already been fixed?


> Then selecting NUMA automatically selects ACPI_SRAT even when ACPI
> is unselected.  The resulting .config won't build:
> 
> arch/i386/kernel/srat.c: In function `parse_cpu_affinity_structure':
> arch/i386/kernel/srat.c:70: error: dereferencing pointer to incomplete type
> 
> static void __init parse_cpu_affinity_structure(char *p)
> {
>         struct acpi_table_processor_affinity *cpu_affinity =
>                                 (struct acpi_table_processor_affinity *) p;
> 
> 70 ===> if (!cpu_affinity->flags.enabled)
>                 return;         /* empty entry */
> 


---
~Randy
