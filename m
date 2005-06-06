Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVFFWSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVFFWSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVFFWSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:18:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:34199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261740AbVFFWOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:14:35 -0400
Date: Mon, 6 Jun 2005 15:14:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk, vatsa@in.ibm.com,
       discuss@x86-64.org, rusty@rustycorp.com.au, ashok.raj@intel.com,
       ak@muc.de
Subject: Re: [patch 5/5] try2: x86_64: Provide ability to choose using
 shortcuts for IPI in flat mode.
Message-Id: <20050606151451.16a0fef3.akpm@osdl.org>
In-Reply-To: <20050606192113.433566000@araj-em64t>
References: <20050606191433.104273000@araj-em64t>
	<20050606192113.433566000@araj-em64t>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> +int print_ipi_mode(void)
> +{
> +	printk ("Using IPI %s mode\n", no_broadcast ? "No-Shortcut" :
> +											"Shortcut");
> +	return 0;
> +}
> +
> +late_initcall(print_ipi_mode);

This function should have static scope and should be marked __init.

