Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271100AbUJUXhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271100AbUJUXhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271051AbUJUXhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:37:04 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:29427 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S271100AbUJUXes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:34:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=r1yXaAQK0Kq/fuZ3fXTgjRQL4kFAbu6bEHS/3nASSSPFL0mpwgj3uerhtm4dB4cxJaZJ5LVafYCMQRg5FPda1MTjr65wpyHcovVU9hmUJcQD82qTrB1rCfyr1/yFtWHgKyUdqDtc+IAsyHRyvoWVT4W03/6oLxXi68NnICqukDw=
Message-ID: <5afb2c65041021163441c1e1b4@mail.gmail.com>
Date: Thu, 21 Oct 2004 21:34:48 -0200
From: Fabiano Ramos <fabiano.ramos@gmail.com>
Reply-To: Fabiano Ramos <fabiano.ramos@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: pid offset into task structre
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All. Some newbie question.

  I am writing some assembly code where I need to access the pid that issue
a certain syscall. In entry.S,  in the syscall stub, I wrote:

   GET_THREAD_INFO(%ebp)
   movl TI_task(%ebp), %ebp
   movl PID_OFFSET(%ebp), %ebx

 Questions are:
    1) Considering that I provided the correct value in PID_OFFSET, will
ebx contain the pid of the task that issued the syscall, at the end of the
fragment?

   2)  By taking some address arithmetic (&tsk.pid - &tsk) I got 144.  Is this
offset always the same? Is that an easy way to get it directly from
assembly code?


TIA,
Fabiano
