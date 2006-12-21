Return-Path: <linux-kernel-owner+w=401wt.eu-S965169AbWLUOkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbWLUOkb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWLUOkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:40:31 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:63623 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965169AbWLUOka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:40:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:sender;
        b=paIN7R+tBloQVBdPRnLbB+76RuVoO8BRskXFBsQFvWQ+rsmp8Zj0oLoFyHCpN4WbIqX+7WMoLg149+BFCWSqeiKY9nhAmc7iarcIY3zN31RQqX+iiLV7MB5sBRKorwuXsQu8HtLB+K8tturTWvKpKZVwgGURCFJ0XLp+1QUfcxw=
Subject: Re: [take28-resend_1->0 0/8] kevent: Generic event handling
	mechanism.
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
In-Reply-To: <20061221143621.GA32706@2ka.mipt.ru>
References: <3154985aa0591036@2ka.mipt.ru> <11666924573643@2ka.mipt.ru>
	 <20061221103539.GA4099@2ka.mipt.ru> <458A64E5.4050703@garzik.org>
	 <20061221104918.GA16744@2ka.mipt.ru> <1166708885.3749.49.camel@localhost>
	 <20061221140429.GA25214@2ka.mipt.ru> <1166710867.3749.56.camel@localhost>
	 <20061221142337.GA17204@2ka.mipt.ru>  <20061221143621.GA32706@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 09:40:26 -0500
Message-Id: <1166712026.3749.60.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-21-12 at 17:36 +0300, Evgeniy Polyakov wrote:

> Btw, it uses only read/write/signal on fd events, so it must use
> ->poll() and thus be as fast as epoll. 
> 

It is supposed to "detect" the best mechanism in the kernel and switch
to that.
At the moment for example in my app it defaults to epoll.

> Things like sockets/pipes can only benefit from direct kevent usage 
> instead of ->poll() and wrappers.

You should be able change it to use those schemes when it detects
that the kernel supports them.

cheers,
jamal

