Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVIUVMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVIUVMm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVIUVMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:12:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750786AbVIUVMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:12:41 -0400
Date: Wed, 21 Sep 2005 14:11:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, ak@muc.de, suresh.b.siddha@intel.com,
       discuss@x86-64.org
Subject: Re: init and zap low address mappings on demand for cpu hotplug
Message-Id: <20050921141157.1bd7aa94.akpm@osdl.org>
In-Reply-To: <20050921135731.B14439@unix-os.sc.intel.com>
References: <20050921135731.B14439@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> +/*
>  + * mode
>  + * 	0 indicates its for __cpu_up to kick an AP into boot sequence.
>  + *  1 indicates completion os smp boot process, so we can zap the low
>  + *    until there is need to bring a cpu up again.
>  + */
>  +__cpuinit void zap_low_mappings(int mode)

grump.  `mode' is a terrible identifier name.  Better to call it something
which identifies its meaning if true, such as `do_mapping_zapping' or
something.

Even better, implement two nicely-named functions rather than passing in a
`mode' argument.  Those functions can of course share a common
mode-selected implementation internally.


And that comment is incomprehensible, partly due to all its typos.  Care to
try again?

