Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVCNXL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVCNXL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVCNXL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:11:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:10700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262022AbVCNXI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:08:26 -0500
Date: Mon, 14 Mar 2005 15:08:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: kjhall@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix gcc printk warnings
Message-Id: <20050314150825.5f52b1a8.akpm@osdl.org>
In-Reply-To: <20050314145522.787a6865.rddunlap@osdl.org>
References: <20050314145522.787a6865.rddunlap@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> -			"invalid count value %x %x \n", count, bufsiz);
> +			"invalid count value %x %lx\n", count, (unsigned long)bufsiz);

Nope.  Please use %Z for size_t args.
