Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268233AbUIGSIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268233AbUIGSIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUIGSGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:06:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28581 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268263AbUIGSG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:06:27 -0400
Subject: Re: [PATCH] sched.c gratious export removal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040907145809.GA9200@lst.de>
References: <20040907145809.GA9200@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094576647.9607.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 18:04:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 15:58, Christoph Hellwig wrote:
> sched.c exports a few internal helpers although none of them is used in
> modular code or code that could easily be made modular, nor would we
> want modules to use them.

>  /**
>   * idle_cpu - is a given cpu idle currently?
>   * @cpu: the processor in question.
> @@ -3152,8 +3147,6 @@
>  {
>  	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
>  }
> -
> -EXPORT_SYMBOL_GPL(idle_cpu);

External power management modules definitely want to know this. 

