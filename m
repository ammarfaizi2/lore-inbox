Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVDAIET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVDAIET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVDAIEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:04:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:59063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262664AbVDAICe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:02:34 -0500
Date: Fri, 1 Apr 2005 00:02:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: connector.c
Message-Id: <20050401000215.6d85c477.akpm@osdl.org>
In-Reply-To: <1112342595.9334.120.camel@uganda>
References: <20050331173026.3de81a05.akpm@osdl.org>
	<1112339238.9334.66.camel@uganda>
	<20050331234213.0c06ba71.akpm@osdl.org>
	<1112342595.9334.120.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> On Thu, 2005-03-31 at 23:42 -0800, Andrew Morton wrote:
>  > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>  > >
>  > > > What happens if we expect a reply to our message but userspace never sends
>  > > > one?  Does the kernel leak memory?  Do other processes hang?
>  > > 
>  > > It is only advice, one may easily skip seq/ack initialization.
>  > > I could remove it totally from the header, but decided to 
>  > > place it to force people to use more reliable protocols over netlink
>  > > by introducing such overhead.
>  > 
>  > hm.  I don't know what that means.
> 
>  Messages that are passed between agents must have only id,
>  but I decided to force people to use provided seq/ack fields
>  to store there some information about message order.
>  Neither kernel nor userspace requires that fields to be 
>  somehow initialized.

Back to my original question.  If the kernel expects a reply from userspace
to a particular message, and that reply never comes, what happens?
