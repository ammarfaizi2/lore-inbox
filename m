Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTJ3NzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTJ3NzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:55:13 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:36529 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262407AbTJ3NzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:55:08 -0500
Message-ID: <00c701c39eed$3aae3900$7708720a@wipro.com>
From: "Anju" <anju.premachandran@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: SMP / HIGHMEM64 affects LKCD
Date: Thu, 30 Oct 2003 19:23:42 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-OriginalArrivalTime: 30 Oct 2003 13:53:42.0468 (UTC) FILETIME=[3AA2A040:01C39EED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am facing some problems with lkcd in 2.4.19 kernel
when SMP and HIGHMEM64 are enabled.

When CONFIG_SMP is set to Y
and when CONFIG_HIGHMEM64 is set,
an invalid dump is produced.

But I get proper dump for all other combinations.
                                      TC1          TC2    TC3   TC4   TC5   TC6 
CONFIG_SMP                Y               Y          Y        N        N       N
CONFIG_HIGHMEM     64              4G    OFF    64G    4G    OFF 

TC1 fails while TC2, TC3, TC4,TC5 and TC6 work!

Following is the behaviour of TC1.
The current system tasks are displayed with "zeros"
in all entries which is the output of 'ps' command.
00000000       0       0       0 0x00 0x00000000     0:0
00000000       0       0       0 0x00 0x00000000     0:0
00000000       0       0       0 0x00 0x00000000     0:0

while no output is shown when given the 'trace command'.
But i can see the output of the 'page' command.

Any suggestions would be of great help

Thanks,
Anju    

