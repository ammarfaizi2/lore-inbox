Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVCJMX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVCJMX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVCJMX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:23:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:53134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262547AbVCJMXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:23:00 -0500
Date: Thu, 10 Mar 2005 04:22:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Discard key spinlock and use RCU for key payload
 [try #3]
Message-Id: <20050310042217.3ba5b9bc.akpm@osdl.org>
In-Reply-To: <4181.1110456111@redhat.com>
References: <4181.1110456111@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> The attached patch changes the key implementation in a number of ways:

That worked.

What's with the preempt_enable()/disable() added to __key_link()?  It's not
obvious what is being protected from what, and why.

