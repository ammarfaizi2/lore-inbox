Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWHIH7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWHIH7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 03:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWHIH7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 03:59:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:63367
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965053AbWHIH7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 03:59:07 -0400
Date: Wed, 09 Aug 2006 00:58:56 -0700 (PDT)
Message-Id: <20060809.005856.104034268.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, netdev@vger.kernel.org,
       zach.brown@oracle.com
Subject: Re: [take6 0/3] kevent: Generic event handling mechanism.
From: David Miller <davem@davemloft.net>
In-Reply-To: <11551105592821@2ka.mipt.ru>
References: <20060731103322.GA1898@2ka.mipt.ru>
	<11551105592821@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Wed, 9 Aug 2006 12:02:39 +0400

Evgeniy, it's things like the following that make it very draining
mentally to review your work.

>  * removed AIO stuff from patchset

You didn't really do this, you leave the aio_* syscalls and stubs in
there, and you also left things like tcp_async_send() in there.

All the foo_naio_*() stuff is still in there to.

Please remove all of async business we've asked you to.

Thanks.
