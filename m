Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSLJQGa>; Tue, 10 Dec 2002 11:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSLJQGa>; Tue, 10 Dec 2002 11:06:30 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:2496 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262258AbSLJQG3>; Tue, 10 Dec 2002 11:06:29 -0500
Subject: Re: 2.4.20-ac1 hangs IBM Thinkpad
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.D. Hood" <jdthood@yahoo.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210125332.69872.qmail@web10305.mail.yahoo.com>
References: <20021210125332.69872.qmail@web10305.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 16:49:41 +0000
Message-Id: <1039538981.14166.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 12:53, J.D. Hood wrote:
> I have also stopped using 2.4.20-ac1 on my ThinkPad.
> It performs much worse than 2.4.20-pre8-ac1 when running
> large applications such as OpenOffice.  (It never crashed
> on me, though.)  Having read the recent thread on changes
> to the scheduler and yield(), I suspect that the problem
> is related to that, since the 2.4-ac series has the O(1)
> scheduler.

Thats a bug in openoffice (or more accurately in the glibc thread
library). Our yield now does what it is *supposed* to do. Unfortunately
glibc is coded to rely on what used to happen. Andrea has a nice fix for
this which I'll probably merge soon

