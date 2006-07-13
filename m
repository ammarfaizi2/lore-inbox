Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWGMNKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWGMNKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWGMNKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:10:23 -0400
Received: from lx-ltd.ru ([85.113.143.174]:38308 "EHLO iserver.lx.intercon.ru")
	by vger.kernel.org with ESMTP id S1030210AbWGMNKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:10:22 -0400
X-Comment-To: Arjan van de Ven
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugs in usb-skeleton.c??? :)
References: <m3odvtvj8w.fsf@lx-ltd.ru>
	<1152791917.3024.39.camel@laptopd505.fenrus.org>
	<m37j2helb4.fsf@lx-ltd.ru>
	<1152795650.3024.44.camel@laptopd505.fenrus.org>
From: Sergej Pupykin <ps@lx-ltd.ru>
Date: 13 Jul 2006 17:10:20 +0400
In-Reply-To: <1152795650.3024.44.camel@laptopd505.fenrus.org>
Message-ID: <m364i17irn.fsf@lx-ltd.ru>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >> Does kmalloc always allocate pages that can be used in DMA?

 AvdV> normally yes. HOWEVER....

I use sh4 cpu...

 AvdV> ..it is nicer to use the DMA allocation API (which internally may fall
 AvdV> back to kmalloc etc), while kmalloc may work, it can be quite slow in
 AvdV> how it's made to work. So it's just nicer to just use the DMA memory
 AvdV> allocators... (see Documentation/DMA-API.txt file for a description of
 AvdV> this)

Thanks, I'll try it.

