Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269019AbTBWW62>; Sun, 23 Feb 2003 17:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269020AbTBWW62>; Sun, 23 Feb 2003 17:58:28 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:3489 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S269019AbTBWW6Y>; Sun, 23 Feb 2003 17:58:24 -0500
Subject: Re: Question about Linux signal handling
From: Albert Cahalan <albert@users.sf.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Albert Cahalan <albert@users.sourceforge.net>, developer_linux@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1046043810.2092.0.camel@irongate.swansea.linux.org.uk>
References: <1046039341.32116.34.camel@cube> 
	<1046043810.2092.0.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Feb 2003 18:04:50 -0500
Message-Id: <1046041491.31809.46.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-23 at 18:43, Alan Cox wrote:
> On Sun, 2003-02-23 at 22:29, Albert Cahalan wrote:

>> Yes. This is the behavior of all SysV UNIX systems
>> and Linux kernels. Unfortunately, BSD got it wrong.
>
> Firstly BSD didn't get it wrong, things merely diverged
> historically after V7 unix.

BSD is wrong for not choosing a different name
for the new system call and leaving the old one.
There could have been a signal2() with the new
behavior. X/Open even did this, with bsd_signal()
as the name. Breaking compatibility is bad.

>> Worse, the glibc developers saw fit to ignore both
>> UNIX history and Linus. They implemented BSD behavior
>> by making signal() use the sigaction system call
>
> Also wrong. If you read the gcc documentation you can
> select favouring BSD or SYS5 behaviour at compile time
>
> glibc has the best of both worlds

Non-default behavior is nearly irrelevant. The default
should have matched traditional UNIX and Linux behavior.

The best of both worlds certainly means traditional
signal() and a bsd_signal(), with a non-default option
to choose the BSD signal() behavior.


