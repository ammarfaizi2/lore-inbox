Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284780AbRLKBha>; Mon, 10 Dec 2001 20:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284776AbRLKBhU>; Mon, 10 Dec 2001 20:37:20 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:57617 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S284779AbRLKBhP>; Mon, 10 Dec 2001 20:37:15 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: [PATCH] Make highly niced processes run only when idle
Date: Tue, 11 Dec 2001 01:36:51 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org>
    <1007939114.878.1.camel@phantasy>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1008034611 10537 10.253.0.3 (11 Dec 2001
    01:36:51 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Tue, 11 Dec 2001 01:36:51 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:132045
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <9v3nvj$a99$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1007939114.878.1.camel@phantasy>,
	Robert Love <rml@tech9.net> writes:
> I've seen a few solutions.  The easiest is to just give idle tasks a
> "boost" on occasion to give them a chance to prevent the deadlock.  You
> then, however, have the problem where the tasks can take advantage of
> the boost...  Or, we could fix in-kernel deadlocks by doing priority
> inheriting on locks held by A and wanted by B (i.e., if A holds

Please don't. Whenever you think you priority inheritance, it's a sign your 
system has got too complicated. The simplest solution is to simply have no
priorities when a task is in-kernel (or at least non that can completely
exclude a task).
