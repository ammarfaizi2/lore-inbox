Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSENLqw>; Tue, 14 May 2002 07:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSENLqv>; Tue, 14 May 2002 07:46:51 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:64522 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315628AbSENLqu>; Tue, 14 May 2002 07:46:50 -0400
Message-Id: <200205141143.g4EBhEY09631@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Robert Love <rml@tech9.net>
Subject: Re: error : preempt_count 1
Date: Tue, 14 May 2002 14:45:40 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1779HB-01zk0WC@fwd06.sul.t-online.com> <1021306688.18799.2564.camel@summit>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 May 2002 14:18, Robert Love wrote:
> > erro: halt[8635] exited with preempt_count 1
> >
> > What does it mean?
>
> Absolutely nothing bad.  It is a debugging check to catch bad code that
> does funny things with locks.  Ideally, every program should call unlock
> for each instance it called lock - balancing everything out and giving a
> preempt_count of zero.

> Some code in the kernel, knowing it is shutting down, does not bother to
> drop any held locks and subsequently you see that message.

> Since it is triggering false positives, I will remove it eventually.

I'd say don't remove it, just omit the 'error:' part - this will
reduce panic mails on the subject.

> For now it is incredibly useful for catching real problems.  And the
> above, while harmless, could be fixed for "cleanliness" concerns.
--
vda
