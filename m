Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbULFWPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbULFWPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULFWPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:15:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:11246 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261677AbULFWPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:15:30 -0500
Date: Mon, 6 Dec 2004 14:15:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4 panic on AMD64
Message-Id: <20041206141515.7f4bd45f.akpm@osdl.org>
In-Reply-To: <1102369238.2826.8.camel@dyn318077bld.beaverton.ibm.com>
References: <1102369238.2826.8.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi Andrew,
> 
> I get following panic while booting 2.6.10-rc2-mm4 on my
> 4-way AMD64 box. Is this known or fixed ?

Well it is known now, but not fixed, afaik.

> Unable to handle kernel paging request at ffffffffd5a4a4fb RIP:
> <ffffffff80657607>{numa_add_cpu+7}

Looks like cpu_to_node(cpu) returned garbage, perhaps.
