Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264081AbTJ1SZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTJ1SZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:25:51 -0500
Received: from yakov.inr.ac.ru ([193.233.7.111]:15517 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S264081AbTJ1SZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:25:49 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200310281825.VAA23218@yakov.inr.ac.ru>
Subject: Re: Linux 2.6.0-test9
To: tommy.christensen@tpack.net (Tommy Christensen)
Date: Tue, 28 Oct 2003 21:25:15 +0300 (MSK)
Cc: torvalds@osdl.org (Linus Torvalds), akpm@osdl.org, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org (Kernel Mailing List), netdev@oss.sgi.com,
       davem@redhat.com (David S. Miller)
In-Reply-To: <3F9DBB7F.7030309@tpack.net> from "Tommy Christensen" at Oct 28, 2003 01:42:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I think the patch breaks things because it consumes (or rather skips)
> the urgent data ( in the code after the label found_ok_skb: ).
> 
> Since this happens before the SIGURG handler is run, it won't find
> any urgent data.
> 
> What do you think?

Yes, you are absolutely right. I missed exactly this thing.


> The patch by Linus seems to be fine though.

I think the patch suggested by Linus is 100% correct and
in fact it is the only solution.

Alexey
