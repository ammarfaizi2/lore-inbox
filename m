Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWDUFUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWDUFUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 01:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWDUFUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 01:20:00 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:37135 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932268AbWDUFT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 01:19:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=cydQ17YviN0GOy8PTVehlTq1FKgxwYvBfZs5NfCffZ518sy6k67Tba4FvFjAq/pUPeCEuWXT+W5juj/N+Jsv0ZwYQPQP+ny0IuqHxZh8yOnR5dHg0N5kSP/asWT6jiUUdS4rpkNkQ9nUOQVvdj6HgFCbdb47mK2a12i15Hco9M0=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Joshua Hudson'" <joshudson@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Rename "swapper" to "idle"
Date: Thu, 20 Apr 2006 22:19:57 -0700
Message-ID: <000301c66503$3bbd8060$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <bda6d13a0604202118t51709a70g1f2402efb8ecbfe@mail.gmail.com>
Thread-Index: AcZk+3ubwqlqs9gZRWaKcmiV2BEFeQAA+nlw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 4/20/06, Bernd Eckenfels <be-news06@lina.inka.de> wrote:
> > Hua Zhong <hzhong@gmail.com> wrote:
> > > This patch renames the "swapper" process (pid 0) to a 
> more appropriate name "idle". The name "swapper" is not 
> obviously meaningful and confuses a lot of people (e.g., when 
> seen in oops report).
> > > Patch not tested, but I guess it works. :-)
> 
> As we saw in "Which process is associated with process ID 0 
> (swapper)", pid 0 can actually do things, such as resend TCP 
> packets. Methinks idle isn't the best name either.

Swapper does not do these things. It just happens to be "running" at that time (and it is always running if the system is idle).

IOW, it is indeed an "idle" process. In fact, all it does is cpu_idle().

> > on win the system idle process shows up in taskmanager so 
> you can see 
> > its cpu usage and ctx switches scheduled from it. We could 
> avoid the 
> > skipping in /proc, also?
> >
> > Gruss
> > Bernd
> Please, no!
> 
> I already have to explain this mess about Windows. We 
> shouldn't be implementing Microsoft's flaws. Why waist the a 
> line of screen for top?
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

