Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVFYXbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVFYXbh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 19:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVFYXbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 19:31:36 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:13268 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261272AbVFYXaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 19:30:18 -0400
Date: Sat, 25 Jun 2005 16:30:13 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Joilnen Leite <knl_joi@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: early_cpu_init
Message-Id: <20050625163013.548c418a.rdunlap@xenotime.net>
In-Reply-To: <20050625225546.54532.qmail@web54501.mail.yahoo.com>
References: <20050625225546.54532.qmail@web54501.mail.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2005 19:55:46 -0300 (ART) Joilnen Leite wrote:

| Hi 
| 
| in the function:
| early_cpu_init we could to change to avoid initialize
| unecessary code ?
| 
| arch/i386/cpu/common.c:536

  arch/i386/kernel/cpu/common.c

| void __init early_cpu_init(void)
| {
| #ifdef CONFIG_MCYRIXIII         
|          cyrix_init_cpu();
| #elif defined CONFIG_MGODE6X1
|          nsc_init_cpu();
| #elif defined CONFIG_MK6 || defined CONFIG_MK7
| ||defined CONFIG_MK8
|          amd_init_cpu();
| #elif defined CONFIG_CRUSOE || defined CONFIG_EFFICEON
|          transmeta_init_cpu();
| #elif defined OTHERS_THAT_I_DONT_KNOW
|          centaur_init_cpu();
|          rise_init_cpu();
|          nexgen_init_cpu();
|          umc_init_cpu();
|          early_cpu_detect();
| #else
|          intel_cpu_init();
| 
| just only a idea.

AFAIK, it's done without the ifdefs so that a common kernel (like a
distro kernel) can run on any of those CPU types.

---
~Randy
