Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270707AbTHSPGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270628AbTHSPEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:04:10 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:47550 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S270707AbTHSO50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:57:26 -0400
Subject: Re: [2.6.0-test3] Sun JDK 1.4.2 doesn't exit properly using NPTL
From: Christophe Saout <christophe@saout.de>
To: r6144 <r6k@sohu.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16193.50055.259400.303737@localhost.localdomain>
References: <16193.50055.259400.303737@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1061305041.4230.0.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 16:57:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, 2003-08-19 um 08.28 schrieb r6144:

> When running it under 2.6.0-test3 with NPTL, the parent process (for
> example bash) locks up after the java process exits.  Strace shows
> that the parent had been waiting in wait4(), but isn't woken up when
> the children (the java process) exits via exit_group().  Sending the
> parent a SIGINT makes wait4() return -ECHILD and the parent continues
> as normal.  The java process runs perfectly normally during its own
> lifetime.

For now you can use the patch at
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm1/broken-out/zap_other_threads-fix.patch

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

