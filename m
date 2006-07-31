Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbWGaWVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbWGaWVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWGaWVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:21:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32908
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751426AbWGaWVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:21:13 -0400
Date: Mon, 31 Jul 2006 15:20:27 -0700 (PDT)
Message-Id: <20060731.152027.116353974.davem@davemloft.net>
To: bcook@bpointsys.com
Cc: johnpol@2ka.mipt.ru, drepper@redhat.com, zach.brown@oracle.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607311716.48455.bcook@bpointsys.com>
References: <20060731194143.GA12569@2ka.mipt.ru>
	<20060731.150028.26276495.davem@davemloft.net>
	<200607311716.48455.bcook@bpointsys.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brent Cook <bcook@bpointsys.com>
Date: Mon, 31 Jul 2006 17:16:48 -0500

> There has to be some thread that is responsible for reading
> events. Perhaps a reasonable thing for a blocked thread that cannot
> process events to do is to yield to one that can?

The reason one decentralizes event processing into threads is so that
once they are tasked to process some event they need not be concerned
with event state.

They are designed to process their event through to the end, then
return to the top level and say "any more work for me?"
