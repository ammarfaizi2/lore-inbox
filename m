Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUEQWMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUEQWMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUEQWMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:12:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:7584 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262909AbUEQWLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:11:34 -0400
Date: Mon, 17 May 2004 15:14:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, james.bottomley@steeleye.com
Subject: Re: [PATCH] init. mca_bus_type even if !MCA_bus
Message-Id: <20040517151412.1f7fb7d4.akpm@osdl.org>
In-Reply-To: <20040517144603.1c63895f.rddunlap@osdl.org>
References: <20040517144603.1c63895f.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> -	if(mca_system_init()) {
> +	if (mca_system_init()) {
>  		printk(KERN_ERR "MCA bus system initialisation failed\n");
>  		return -ENODEV;
>  	}
>  
> +	if (!MCA_bus)
> +		return -ENODEV;

Why is it appropriate to register the MCA bus type when there is no
MCA bus present?
