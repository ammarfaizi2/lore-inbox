Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbVIVA3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbVIVA3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 20:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbVIVA3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 20:29:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965194AbVIVA3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 20:29:19 -0400
Date: Wed, 21 Sep 2005 17:28:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: gcoady@gmail.com
Cc: grant_lkml@dodo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Query: How fix: `ide_generic_all_on' defined but not used??
Message-Id: <20050921172835.005caf11.akpm@osdl.org>
In-Reply-To: <mpn3j1p9n087sq45le5tio0np8aoa3s11a@4ax.com>
References: <mpn3j1p9n087sq45le5tio0np8aoa3s11a@4ax.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady <grant_lkml@dodo.com.au> wrote:
>
> drivers/ide/pci/generic.c:45: warning: `ide_generic_all_on' defined but not used
> 
> 
>  Source:
>  ...
>  static int ide_generic_all;             /* Set to claim all devices */
> 
>  static int __init ide_generic_all_on(char *unused)
>  {
>          ide_generic_all = 1;
>          printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.\n");
>          return 1;
>  }
> 
>  __setup("all-generic-ide", ide_generic_all_on);
>  ...
> 
>  How to silence this type of warning?

You could try poking around in the __setup() definition, using
__attribute_used__, perhaps.

