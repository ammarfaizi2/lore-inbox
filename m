Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWFMVnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWFMVnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWFMVnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:43:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932337AbWFMVnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:43:16 -0400
Date: Tue, 13 Jun 2006 14:43:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: drfickle@us.ibm.com, pbadari@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
Message-Id: <20060613144304.2e846fb1.akpm@osdl.org>
In-Reply-To: <448EC74F.30104@ru.mvista.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	<pan.2006.06.12.22.09.47.855327@us.ibm.com>
	<20060613065443.7f302319.akpm@osdl.org>
	<448EC74F.30104@ru.mvista.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006 18:10:23 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> 
> > Thanks.   Reverting the below might fix it.
> 
>     Frankly speaking, I don't see how that can be possible. I haven't touched 
> any *real* checks in ide_allocate_dma_engine(), so it should fail regardless 
> of my patch. I'd rather supposed that pci_alloc_consistent() had failed...
> 

Oh, OK, yes, sorry, you're right, I forgot.  pci_alloc_consistent() is
broken on powerpc in that kernel.
