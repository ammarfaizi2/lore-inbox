Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317614AbSFRUmt>; Tue, 18 Jun 2002 16:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317613AbSFRUms>; Tue, 18 Jun 2002 16:42:48 -0400
Received: from mail.webmaster.com ([216.152.64.131]:53649 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317612AbSFRUml> convert rfc822-to-8bit; Tue, 18 Jun 2002 16:42:41 -0400
From: David Schwartz <davids@webmaster.com>
To: <mgix@mgix.com>, <rml@tech9.net>
CC: <root@chaos.analogic.com>, Chris Friesen <Chris.Friesen@vax.home.local>,
       <cfriesen@nortelnetworks.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 13:42:36 -0700
In-Reply-To: <AMEKICHCJFIFEDIBLGOBEEEKCBAA.mgix@mgix.com>
Subject: RE: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020618204237.AAA5802@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Now, if I understand you well enough David, you'd like an
>algorithm where the less you want the CPU, the more you get
>it.

	Exactly. This is the UNIX tradition of static and dynamic priorities. The 
more polite you are about yielding the CPU when you don't need it, the more 
claim you have to getting it when you do need it.

>I'd love if you could actually give us an outlook of
>your ideal scheduler so I can try my thought experiment on it,
>because from what I've understood so far, your hypothetical
>scheduler would allocate all of the CPU to the yielders.

	Not all, just the same share any other process gets. They're all 
ready-to-run, they're all at the same priority.

>Also, since it seems to worry you: no I'm not using sched_yield
>to implement pseudo-blocking behaviour.

	Then tell us what you are doing so we can tell you the *right* way to do it. 
Unless this is just an abstract theoretical exercise, you shouldn't complain 
when ready-to-run threads get the CPU.

	DS


