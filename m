Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWJWDPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWJWDPv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWJWDPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:15:51 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:52831 "EHLO
	asav02.insightbb.com") by vger.kernel.org with ESMTP
	id S1751191AbWJWDPv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:15:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAFHQO0VKhRUUXWdsb2JhbACBTIpLLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: =?utf-8?q?N=C3=A9meth_M=C3=A1rton?= <nm127@freemail.hu>
Subject: Re: [patch] input: function call order in serio_exit()
Date: Sun, 22 Oct 2006 23:15:47 -0400
User-Agent: KMail/1.9.3
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <453B921D.80008@freemail.hu>
In-Reply-To: <453B921D.80008@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610222315.48592.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 11:45, Németh Márton wrote:
> Hi,
> 
> the order of the bus registration and the kthread start was changed
> between linux kernel 2.6.17.11 and 2.6.18. The order is now first
> register the bus and then start the kthread. The serio_exit() left
> unchanged.
> 
> I think that the order of the function calls in serio_exit() should also
> be changed: first stop the kthread and then unregister the bus.
> 
> What do you think?
> 

Hi,

It really does not matter - if bus is unregistered that means the there
are no drivers using it and so noone can submit new requests to kseriod.

I'd leave it as is.

-- 
Dmitry
