Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWCVJBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWCVJBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWCVJBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:01:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38038 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751102AbWCVJBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:01:15 -0500
Subject: Re: [PATCH 2/2] Add full sysfs support to the IPMI driver
From: Arjan van de Ven <arjan@infradead.org>
To: minyard@acm.org
Cc: greg@kroah.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Yani Ioannou <yani.ioannou@gmail.com>
In-Reply-To: <20060321221328.GB27436@i2.minyard.local>
References: <20060321221328.GB27436@i2.minyard.local>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 10:01:09 +0100
Message-Id: <1143018069.2955.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 16:13 -0600, Corey Minyard wrote:


> +static void ipmi_bmc_release(struct device *dev)
> +{
> +	printk(KERN_DEBUG "ipmi_bmc release\n");
> +}


eehhhh NO.
Please read the many comments and documentations about why a release
function is NOT allowed to be empty. In fact the kernel warned you about
that, didn't it? 

