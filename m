Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbUCEGt0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 01:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbUCEGsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 01:48:52 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:59999 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262127AbUCEGsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 01:48:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [NET_SCHED] BUG in qdisc TBF (token bucket filter)
Date: Fri, 5 Mar 2004 01:47:26 -0500
User-Agent: KMail/1.6
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       marek cervenka <cer20um@axpsu.fpf.slu.cz>, linux-net@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
References: <Pine.LNX.4.58.0403031323140.6655@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.58.0403031323140.6655@ask.diku.dk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403050144.17622.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 March 2004 07:31 am, Jesper Dangaard Brouer wrote:
> 
> BUG in qdisc TBF (token bucket filter).
> 
>  Problem in    : Kernel 2.4.22 (and newer, tested till 2.4.25-rc2)
>  Problem NOT in: kernel 2.4.21 (and older)
> 
> Problem:
> --------
>  After I add an tbf qdisc to an htb class, then the htb class disappear
>  from the output-listing "tc -s class ls dev ethX".
> 

Yeah, I botched class reporting in TBF, I am sending 2 patches as followups
to this message:

01-tbf-class-reporting.patch - actual fix
02-tbf-trailing-whitespace.patch - removes trailing whitespace from TBF code

The patches are against 2.6 but I am pretty sure they will apply to 2.4.

-- 
Dmitry
