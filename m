Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUJRUNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUJRUNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUJRUKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:10:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17582 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267700AbUJRTfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:35:32 -0400
Date: Mon, 18 Oct 2004 15:35:16 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Matt Domsch <Matt_Domsch@dell.com>
cc: davem@davemloft.net, <linux-kernel@vger.kernel.org>,
       Oleg Makarenko <mole@quadra.ru>
Subject: Re: using crypto_digest() on non-kmalloc'd memory failures
In-Reply-To: <20041018192952.GB8607@lists.us.dell.com>
Message-ID: <Xine.LNX.4.44.0410181534180.24062-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Matt Domsch wrote:

> James, David,
> 
> Oleg noted that when we call crypto_digest() on memory allocated as a
> static array in a module, rather than kmalloc(GFP_KERNEL), it returns
> incorrect data, and with other functions, a kernel panic.
> 
> Thoughts as to why this may be?  Oleg's test patch appended.

I don't recall the exact details, but it's related to using kmap in the 
core crypto code.


- James
-- 
James Morris
<jmorris@redhat.com>


