Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292144AbSBAXjX>; Fri, 1 Feb 2002 18:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292145AbSBAXjN>; Fri, 1 Feb 2002 18:39:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24076 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292144AbSBAXi5>; Fri, 1 Feb 2002 18:38:57 -0500
Subject: Re: Artificially starving a process for CPU/Disk/etc?
To: nneul@umr.edu (Neulinger, Nathan)
Date: Fri, 1 Feb 2002 23:51:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A69C6C0DB9068F40AC122C194F9DBEF0AEBD@umr-mail1.umr.edu> from "Neulinger, Nathan" at Feb 01, 2002 12:29:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WnTL-0006WL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've got a situation where I want to simulate a server process getting 
> starved for cpu/paging to death/etc. I realize I could renice the process(s)
> and then create artificial loading on the machine, but is there any way to 
> do this more effectively?

There are a couple of approaches. One is to use ptrace the other
just signals and keep stopping/starting the process. Neither will give 
accurate paging to death behaviour. To get that you would have to do some
simulated fault and pauses every new page access.

Alan
