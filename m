Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbTCRR5w>; Tue, 18 Mar 2003 12:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbTCRR5w>; Tue, 18 Mar 2003 12:57:52 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:55048
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262130AbTCRR5v>; Tue, 18 Mar 2003 12:57:51 -0500
Subject: Re: process resident in memory
From: Robert Love <rml@tech9.net>
To: mersan@ceng.metu.edu.tr
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E772B7D.3010309@ceng.metu.edu.tr>
References: <3E76BCA9.3060902@ceng.metu.edu.tr>
	 <20030318134238.GA22953@riesen-pc.gr05.synopsys.com>
	 <3E772604.5050604@ceng.metu.edu.tr>
	 <Pine.LNX.4.53.0303180901001.26924@chaos>
	 <3E772B7D.3010309@ceng.metu.edu.tr>
Content-Type: text/plain
Organization: 
Message-Id: <1048010915.828.120.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 18 Mar 2003 13:08:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 09:21, Mehmet Ersan TOPALOGLU wrote:

> first of all i don't have chance to modify the process' code.
> the thing mlockall does is exactly what i am trying to do
> (at least a part of it).
> 
> So your answer is he couldn't know about user-mode so it is not possible.
> What if kernel forks that process or somehow its process id is informed 
> to kernel?

nice works given a PID.  You can call renice(1) from the command line or
you can use the nice(2) or setpriority(2) system calls.

Note you need to be root to lower the nice value (increase the priority)
of a process.

Unfortunately mlockall() only works from a process in the address
space.  And it is not inherited on fork().  Tough luck.

	Robert Love



