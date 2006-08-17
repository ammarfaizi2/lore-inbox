Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWHQGys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWHQGys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWHQGys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:54:48 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:5045 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S932080AbWHQGyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:54:46 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(203.129.230.146):SA:0(-102.5/1.7):. Processed in 1.365544 secs Process 15318)
From: "Abu M. Muttalib" <abum@aftek.com>
To: <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: Relation between free() and remove_vm_struct()
Date: Thu, 17 Aug 2006 12:29:15 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMKEEHDGAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In an application I am freeing some memory address, earlier reserved with
malloc.

I have put prints in remove_vm_struct() function in ./mm/mmap.c. For few
calls to free(), there is no corresponding call to remove_vm_struct(). I am
not able to understand why the user space call to free() is not propagated
to kernel, where in the remove_vm_strcut() function should get called.

Please help.

Regards,
Abu.


