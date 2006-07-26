Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWGZKMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWGZKMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWGZKMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:12:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8346
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751334AbWGZKMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:12:44 -0400
Date: Wed, 26 Jul 2006 03:12:47 -0700 (PDT)
Message-Id: <20060726.031247.98341392.davem@davemloft.net>
To: hch@infradead.org
Cc: johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060726100431.GA7518@infradead.org>
References: <1153905495613@2ka.mipt.ru>
	<11539054952574@2ka.mipt.ru>
	<20060726100431.GA7518@infradead.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 26 Jul 2006 11:04:31 +0100

> And to be honest, I don't think adding all this code is acceptable
> if it can't replace the existing aio code while keeping the
> interface.  So while you interface looks pretty sane the
> implementation needs a lot of work still :)

Networking and disk AIO have significantly different needs.

Therefore, I really don't see it as reasonable to expect
a merge of these two things.  It doesn't make any sense.

I do agree that this stuff needs to be cleaned up, all the get_block
etc. hacks have to be pulled out and abstracted properly.  That part
of the kevent changes are indeed still crap :)
