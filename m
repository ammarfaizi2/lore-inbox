Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264506AbUEEKzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbUEEKzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 06:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUEEKzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 06:55:23 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:39181 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264506AbUEEKzU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 06:55:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Libor Vanek <libor@conet.cz>, Bart Samwel <bart@samwel.tk>
Subject: Re: Read from file fails
Date: Wed, 5 May 2004 13:54:43 +0300
X-Mailer: KMail [version 1.4]
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
References: <20040503000004.GA26707@Loki> <4098BC2B.4080601@samwel.tk> <20040505101902.GB6979@Loki>
In-Reply-To: <20040505101902.GB6979@Loki>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200405051354.43397.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 May 2004 13:19, Libor Vanek wrote:
> > Libor Vanek wrote:
> > >OK - how can I "notify" userspace process? Signals are "weak" - I need
> > > to send some data (filename etc.) to process. One solution is "on this
> > > signal call this syscall and result of this syscall will be data you
> > > need" - but I'd prefer to handle this in one "action".
> >
> > My first thoughts are to make it a blocking call.
>
> You mean like:
> - send signal to user-space process
> - wait until user-space process pick ups data (filename etc.), creates copy
> of file (or whatever) and calls another system call that he's finished -
> let kernel to continue syscall I blocked
> ?

I think he meant that userspace daemon should do a blocking syscall
(a read for example). When that returns, daemon knows he has
something to do.
--
vda
