Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVAEWYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVAEWYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 17:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAEWY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 17:24:29 -0500
Received: from animx.eu.org ([216.98.75.249]:11668 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262587AbVAEWYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 17:24:25 -0500
Date: Wed, 5 Jan 2005 17:33:20 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Re: Oops on megaraid.
Message-ID: <20050105223320.GA7622@animx.eu.org>
Mail-Followup-To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20050105174752.GA6859@animx.eu.org> <20050105180457.GK26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105180457.GK26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> Someone's removing non-empty directory in procfs.  Let's see...
> Indeed.
> #ifdef CONFIG_PROC_FS
>         remove_proc_entry("megaraid", &proc_root);
> #endif
> 
>         pci_unregister_driver(&megaraid_pci_driver);
> so we remove /proc/megaraid and then procees to remove controllers found
> by driver.  Each of those has a subdirectory in /proc/megaraid...
> 
> Fix is trivial:

Cool, thanks.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
