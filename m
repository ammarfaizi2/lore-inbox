Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbUKJOgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbUKJOgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUKJOdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:33:35 -0500
Received: from smtp.cs.aau.dk ([130.225.194.6]:11464 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S261935AbUKJOZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:25:19 -0500
Subject: Changes Pthreads, Mutexes and Co. ?
From: Emmanuel Fleury <fleury@cs.aau.dk>
To: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1100096653.3305.9.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 10 Nov 2004 15:24:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am using the software Cinelerra and I noticed that it was
systematically crashing (segfaults) under 2.6.9 where using a 2.6.7 was
ok. After looking more in depth at the problem it seems that the main
issue comes from the fact that several objects (it's C++) are tested in
one thread while they are freed in another. Changing from 2.6.7 to 2.6.9
seems to make it possible to have the free(object) occurring before the
test which leads to a segfault.

So, my little question is: "Did something changed recently in the kernel
about mutexes, phtreads, and so on ???" 

I didn't find anything obvious about this by browsing the web.

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.aau.dk

