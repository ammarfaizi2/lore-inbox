Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbTBGRDL>; Fri, 7 Feb 2003 12:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbTBGRDL>; Fri, 7 Feb 2003 12:03:11 -0500
Received: from www.amthinking.net ([65.104.119.37]:51413 "EHLO
	ex0.amthinking.net") by vger.kernel.org with ESMTP
	id <S266069AbTBGRDJ>; Fri, 7 Feb 2003 12:03:09 -0500
From: "James Lamanna" <james.lamanna@appliedminds.com>
To: <linux-kernel@vger.kernel.org>
Subject: Scanf behavior
Date: Fri, 7 Feb 2003 09:12:46 -0800
Message-ID: <010e01c2cecc$22200810$39140b0a@amthinking.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 07 Feb 2003 17:12:45.0923 (UTC) FILETIME=[22057B30:01C2CECC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at addressing bug #189 on bugzilla which calls for scanf
to respect field_widths for numeric arguments (i.e. %2hd)
2 semantic issues I thought of:

1) Should the field width ignore any number modifiers ( '0x' for hex,
'0' for octal, '-' for negatives) ?
For example a field_width of 1 on the string "0x5F" should return 0 or
0x5 
(I would think the latter is much more appropriate).

2) What about a field_width of 0? Always return 0?

Thanks,
--James

