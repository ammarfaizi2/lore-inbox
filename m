Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbTD1M0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTD1M0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:26:10 -0400
Received: from [155.223.251.1] ([155.223.251.1]:4014 "HELO
	gatekeeper.ege.edu.tr") by vger.kernel.org with SMTP
	id S261801AbTD1M0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:26:09 -0400
From: "Kasim Sinan Yildirim" <yildirim@bilmuh.ege.edu.tr>
To: linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Paging and system calls
Date: Mon, 28 Apr 2003 14:48:08 +0200
Message-Id: <20030428124808.M37677@bilmuh.ege.edu.tr>
X-Mailer: Open WebMail 1.81 20021127
X-OriginatingIP: 155.223.24.232 (yildirim)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on a small kernel and i am examining the source code of the 
linux.

Since every task has its own page tables, when task switching occurs,  the 
cr3 field of the TSS is put to the cr3 register which is page directory base 
register.

Ýn my operating system, when a system call occurs, the user level code jumps 
to system level code by changing its selectors to KernelCS and KernelDS. But 
at this point, the cr3 register still points to the page directory of the 
user process. So, the actual code that is pointed by kernel level page 
directory is not equal to the user level page directory entry. As a result , 
the system fails.

How this problem is solved in Linux? Have you got any solution to my problem?

Thanks...


