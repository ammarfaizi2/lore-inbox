Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUJQSEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUJQSEo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUJQSEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:04:44 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:59670 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269243AbUJQSEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:04:21 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Spx9NuhzQvgLRGAPoPiFtHmKhXFMjDtmTC4IOEdibrU4Mc58bond4WiNilZ8vcMOSRv7c3I0LjOy5Ajvru3jZMyiKNfNxE8pbVumqqpMITPT3rimuX4dTOle2ShWOeUPvyZHBk67pMq1F0XXKY3AyRxjpc6+K5uU8cAHvmusi8o
Message-ID: <5d6b65750410171104320bc6a8@mail.gmail.com>
Date: Sun, 17 Oct 2004 20:04:21 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Cc: Lars Marowsky-Bree <lmb@suse.de>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410171921440.2952@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041016062512.GA17971@mark.mielke.cc>
	 <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
	 <20041017133537.GL7468@marowsky-bree.de>
	 <5d6b657504101707175aab0fcb@mail.gmail.com>
	 <20041017150509.GC10280@mark.mielke.cc>
	 <5d6b65750410170840c80c314@mail.gmail.com>
	 <Pine.LNX.4.61.0410171921440.2952@dragon.hygekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004 19:35:03 +0200 (CEST), Jesper Juhl <juhl-lkml@dif.dk> wrote:

> Personally I agree that if you want non blocking sockets that's what you
> should use, but many people expect that if select says a socket is
> readable then attempting to recieve that data will not block. Many people
> refer to Stevens "UNIX Network Programming" to find out how select and
> related networking functions are supposed to behave, and Stevens has this

[ snip ]

Also note the examples that Stevens gives. For instance, he explicitly
checks for EWOULDBLOCK after a read on a nonblocking fd that has been
reported readable by select().


Cheers,
Buddy
