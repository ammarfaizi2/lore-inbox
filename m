Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSGWKL1>; Tue, 23 Jul 2002 06:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSGWKL1>; Tue, 23 Jul 2002 06:11:27 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:30616 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id <S318014AbSGWKL1>;
	Tue, 23 Jul 2002 06:11:27 -0400
Message-ID: <3D3D2C87.F7E54649@isg.de>
Date: Tue, 23 Jul 2002 12:14:31 +0200
From: Peter Niemayer <niemayer@isg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: read/recv sometimes returns EAGAIN instead of EINTR on SMP machines
References: <20020723081257.AAA26793@shell.webmaster.com@whenever>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

>         My guess is that select did return EINTR, but for some reason your
> application examined the fd sets anyway. So the bug is in not ignoring the fd
> sets when select returns an error, which is an application issue.

As you can see in the sample source code I provided, the problem is not
caused by the application not testing select() for returning EINTR - in
that case, the code just select()s again...

Regards,

Peter Niemayer
