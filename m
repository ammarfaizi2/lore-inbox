Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264427AbUEEKTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264427AbUEEKTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 06:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbUEEKTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 06:19:44 -0400
Received: from firewall.conet.cz ([213.175.54.250]:27329 "EHLO conet.cz")
	by vger.kernel.org with ESMTP id S264427AbUEEKTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 06:19:43 -0400
Date: Wed, 5 May 2004 12:19:02 +0200
From: Libor Vanek <libor@conet.cz>
To: Bart Samwel <bart@samwel.tk>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
Message-ID: <20040505101902.GB6979@Loki>
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos> <20040503150606.GB6411@Loki> <Pine.LNX.4.53.0405032020320.12217@chaos> <20040504011957.GA20676@Loki> <4097A94C.8060403@samwel.tk> <20040505095406.GC5767@Loki> <4098BC2B.4080601@samwel.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4098BC2B.4080601@samwel.tk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Libor Vanek wrote:
> >OK - how can I "notify" userspace process? Signals are "weak" - I need
> > to send some data (filename etc.) to process. One solution is "on this
> > signal call this syscall and result of this syscall will be data you
> > need" - but I'd prefer to handle this in one "action".
> My first thoughts are to make it a blocking call.

You mean like:
- send signal to user-space process
- wait until user-space process pick ups data (filename etc.), creates copy of file (or whatever) and calls another system call that he's finished
- let kernel to continue syscall I blocked
?

Libor
