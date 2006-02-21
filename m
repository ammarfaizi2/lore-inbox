Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWBUUB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWBUUB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWBUUB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:01:28 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:65417 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932557AbWBUUB2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:01:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EbZAA8iuNQyl9XV7oXiweoqAm+8XFuCOwvXFdOSlcMPwr9s1r/d3mgV7ZJs/LbtQS/idpANxI+BDg7X0wmInc3swT97cCwMLw0F+N9IYmC6LoTfYkuyOdJwA2R9oW4h8wb87K5LfP8eBXT9RfHLkJyVaZrRYxchye2bwIkBF1vk=
Message-ID: <9a8748490602211201q4dc85bf2j41d9aace75a8b0bc@mail.gmail.com>
Date: Tue, 21 Feb 2006 21:01:27 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: synchro-test results in case someone cares
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I assume the reason for including the synchro-test.ko module in the
standard kernel is to get people to run it :)

I realize that it's ofcourse most useful when it finds bugs, but I
thought it might be interresting to get some results from people even
when it doesn't find any bugs, so here are some results from a Athlon
64 X2 4400+ system running a 32bit 2.6.16-rc4-mm1 SMP kernel :

# insmod /lib/modules/2.6.16-rc4-mm1/kernel/kernel/synchro-test.ko 
mx=19 sm=18 ism=17 rd=14 wr=11 dg=7 elapse=180 load=5 interval=3
do_sched=1 v=1
# dmesg | tail -n 12
Starting synchronisation primitive tests...
MTX: 5% 5% 5% 5% 5% 5% 5% 5% 5% 5% 5% 5% 5% 5% 5% 5% 5% 5% 5%
SEM: 5% 6% 5% 5% 6% 5% 5% 5% 5% 5% 4% 5% 5% 5% 5% 4% 5% 5%
RD : 7% 7% 7% 7% 7% 7% 7% 7% 7% 7% 7% 7% 7% 7%
WR : 11% 11% 11% 11% 10% 11% 11% 5% 5% 5% 5%
DG : 14% 14% 14% 14% 14% 14% 14%
mutexes taken: 2734420
semaphores taken: 28575064
reads taken: 11350253
writes taken: 14461007
downgrades taken: 5628114
Tests complete

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
