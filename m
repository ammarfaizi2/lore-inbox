Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUJRUdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUJRUdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUJRUch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:32:37 -0400
Received: from mail3.iserv.net ([204.177.184.153]:59779 "EHLO mail3.iserv.net")
	by vger.kernel.org with ESMTP id S265805AbUJRUaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:30:22 -0400
Message-ID: <417427D4.6080704@didntduck.org>
Date: Mon, 18 Oct 2004 16:30:12 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: jmorris@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       Oleg Makarenko <mole@quadra.ru>
Subject: Re: using crypto_digest() on non-kmalloc'd memory failures
References: <20041018192952.GB8607@lists.us.dell.com>
In-Reply-To: <20041018192952.GB8607@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> James, David,
> 
> Oleg noted that when we call crypto_digest() on memory allocated as a
> static array in a module, rather than kmalloc(GFP_KERNEL), it returns
> incorrect data, and with other functions, a kernel panic.
> 
> Thoughts as to why this may be?  Oleg's test patch appended.
> 

On some arches modules reside in vmalloc space.

--
				Brian Gerst
