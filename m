Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTJVIWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 04:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTJVIWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 04:22:22 -0400
Received: from [203.199.54.175] ([203.199.54.175]:24071 "EHLO
	MailRelay.lntinfotech.com") by vger.kernel.org with ESMTP
	id S263447AbTJVIWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 04:22:21 -0400
From: "Suresh Subramanian" <Suresh.Subramanian@lntinfotech.com>
Subject: problem in locking a task
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OF48A13FB5.91AEE935-ON65256DC7.002D5CD4@lntinfotech.com>
Date: Wed, 22 Oct 2003 13:51:07 +0530
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on BANGALORE/LNTINFOTECH(Release 5.0.9 |November 16, 2001) at
 10/22/2003 01:51:08 PM,
	Itemize by SMTP Server on MailRelay/LNTINFOTECH(Release 5.0.12  |February
 13, 2003) at 10/22/2003 02:06:20 PM,
	Serialize by Router on MailRelay/LNTINFOTECH(Release 5.0.12  |February 13, 2003) at
 10/22/2003 02:06:24 PM,
	Serialize complete at 10/22/2003 02:06:24 PM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody

Problem Statement: Command to lock the processor with a specific task or
function & disable the scheduler from preempting the function untill the
task reaches its completion.

Probable Solutions :using         1)spin_lock & spin_unlock
                                    2)lock_kernel & unlock_kernel
                              3)cli(for disabling the timer interrupt to
the scheduler)
                                          4)disable_irq(0) &
enable_irq(0)(for the same reason stated above)

Issues: Unable to create test stubs or scenarios where the processor is
scheduled between several processes, since a sleep command relinquishes the
processor voluntarily & a loop ties the processor till its completion.

Required Solutions: Either the generation of suitable test stubs or a new
solution catering to our needs.

Thank you.

