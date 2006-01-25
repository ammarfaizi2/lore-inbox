Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWAYUNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWAYUNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWAYUNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:13:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21696 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750737AbWAYUNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:13:38 -0500
Date: Wed, 25 Jan 2006 12:13:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, kaos@sgi.com,
       randy.d.dunlap@intel.com
Subject: Re: wrongly marked __init/__initdata for CPU hotplug
Message-Id: <20060125121317.478462fc.akpm@osdl.org>
In-Reply-To: <20060125120253.A30999@unix-os.sc.intel.com>
References: <20060125120253.A30999@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
>  void __cpuinit mcheck_init(struct cpuinfo_x86 *c)
>   {
>  -	static cpumask_t mce_cpus __initdata = CPU_MASK_NONE;
>  +	static cpumask_t mce_cpus = CPU_MASK_NONE;

Should that be __cpuinitdata?
