Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTFIRVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTFIRVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:21:16 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:39582 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264471AbTFIRVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:21:15 -0400
To: "David Schwartz" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: select for UNIX sockets?
References: <MDEHLPKNGKAHNMBLJOLKKEHBDIAA.davids@webmaster.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 09 Jun 2003 19:18:14 +0200
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEHBDIAA.davids@webmaster.com>
Message-ID: <m3znkr41bd.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

> 	It really doesn't matter. UDP applications have to control the transmit
> pacing at application level. There is absolutely no way for the kernel to
> know whether the path to the recipient is congested or not.

Because what? The kernel knows everything it has to know - i.e. complete
state of socket queue in question.

But if select() on sockets is illegal, should we make it return -Esth
instead of success. Certainly, we should get rid of invalid kernel code,
right?

> 	The kernel can't tell you when to send because that depends upon
> factors
> that are remote.

Such as?

> 	Yes, it would be nice of the kernel helped more. But the application
> has to
> deal with remote packet loss as well.

Could you please show me a place in the kernel which could cause such
a loss on local datagram sockets?
-- 
Krzysztof Halasa
Network Administrator
