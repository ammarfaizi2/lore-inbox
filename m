Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTKODfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 22:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTKODfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 22:35:20 -0500
Received: from uirapuru.fua.br ([200.129.163.1]:5348 "EHLO uirapuru.fua.br")
	by vger.kernel.org with ESMTP id S261326AbTKODfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 22:35:15 -0500
Message-ID: <3123.200.208.225.32.1068863764.squirrel@webmail.ufam.edu.br>
Date: Sat, 15 Nov 2003 00:36:04 -0200 (BRST)
Subject: Getting the size of heap, stack code and data in physical memory
From: edjard@ufam.edu.br
To: linux-kernel@vger.kernel.org
Cc: Mauricio.Lin@indt.org.br, Allan.Bezerra@indt.org.br, ajsb@dcc.fua.br,
       mauriciolin@bol.com.br
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

We have tried to find out answer to our questions at the kernelnewbies
list, but after many mails we had no conclusive opinion. Does any one
here have n idea on how to solve it?

The hacking challenge is:
We are looking for a structure or variables that represent the size
of heap, stack, code and data in physical memory. We found some
structures on kernel source 2.6 like mm_struct and vm_area_struct,
but these structures give the size of process (stack,code, data, heap
separately) allocated in virtual memory. The only information we
found about physical memory is rss, but this variable does not provide
the size of stack, code, data, heap separately.

The pmap of Linux doesn't provide these data also since it is
actually inside /proc.

We think the only way to get this information is through the way
the page table sets the page resident flag and use some variables
to calculate the size of such elements (stack, code, data, heap)
allocated in physical memory. But the implementation of page
table is not trivial, the same for pgd, pmd and pte.

We'd like to know if it is possible to calculate the size of these
elements without losing the OS performance?

Is there any better solution to do that?

Edjard

