Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTIRVrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 17:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTIRVrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 17:47:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:2968 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262161AbTIRVrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 17:47:06 -0400
Date: Thu, 18 Sep 2003 14:28:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG at mm/memory.c:1501 in 2.6.0-test5
Message-Id: <20030918142811.1183c40f.akpm@osdl.org>
In-Reply-To: <20030918202758.GA26435@vana.vc.cvut.cz>
References: <20030918202758.GA26435@vana.vc.cvut.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>
> kernel BUG at mm/memory.c:1501!

Something somewhere somehow set the _PAGE_FILE bit in a pagetable page. 
That's all we know, really.

If it's repeatable it would be interesting to print out the entire pte
value, and its neighbours, to take a look at the corruption pattern and see
if that yields any hints.

