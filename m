Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUCUXYd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUCUXYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:24:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:53193 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261460AbUCUXYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:24:31 -0500
Date: Sun, 21 Mar 2004 15:24:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: m.c.p@wolk-project.de, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: do we want to kill VM_RESERVED or not? [was Re: 2.6.5-rc1-aa3]
Message-Id: <20040321152427.61d88cea.akpm@osdl.org>
In-Reply-To: <20040321114939.GA10787@dualathlon.random>
References: <20040320210306.GA11680@dualathlon.random>
	<200403211105.05908@WOLK>
	<20040321114939.GA10787@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> believe my robustness
>  BUG_ON are correct and this is not a false positive, if we want to kill
>  VM_RESERVED I can remove the BUG_ON(reserved == pageable) which is the one
>  triggering with vmware right now]

I'd prefer to retain VM_RESERVED and work toward removing PageReserved(). 
The latter has a real and measurable cost in put_page().

