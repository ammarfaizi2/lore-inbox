Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTFBPyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbTFBPyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:54:04 -0400
Received: from dns01.mail.yahoo.co.jp ([211.14.15.204]:16461 "HELO
	dns01.mail.yahoo.co.jp") by vger.kernel.org with SMTP
	id S262497AbTFBPyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:54:03 -0400
Message-ID: <006001c32921$0be01400$570486da@w0a3t0>
From: "matsunaga" <matsunaga_kazuhisa@yahoo.co.jp>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: <linux-mtd@lists.infradead.org>, "David Woodhouse" <dwmw2@infradead.org>,
       <linux-kernel@vger.kernel.org>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de><002901c32919$ddc37000$570486da@w0a3t0> <20030602153656.GA679@wohnheim.fh-wedel.de>
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Date: Tue, 3 Jun 2003 01:07:20 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not bad.  We can even do a little better.  Since only one workspace is
> really absolutely necessary (ignoring the siftirq case), there is no
> need to fail anymore.  If we don't get enough memory for all
> workspaces, initialize the semaphore to be a little lower and live
> with fewer workspaces.
> 
> I like your ideas, really! :)

Thanks.
 
> ...that is not trivial to get rid of.  Image the case where two
> processes are writing to two devices.  With two buffers, we do rmew
> whenever switching blocks for one device.  With one buffer, we have to
> do it for every context switch between those two processes, which will
> wear down the flash a lot faster.
> 
> Considering that mtdblock should not be performance critical in
> production use anyway, this is a very hard problem.  What do you
> think?

I understand the difficulty. It is difficult to be hard coded for multi devices.
There maybe other things to be modified to improve perforamance.

BR.
Matsunaga

