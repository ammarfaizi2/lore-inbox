Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbTIGSi3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTIGSi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:38:29 -0400
Received: from h011.c007.snv.cp.net ([209.228.33.239]:56237 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id S261274AbTIGSi2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:38:28 -0400
X-Sent: 7 Sep 2003 18:38:26 GMT
Message-ID: <001301c3756f$18f847d0$323be90c@bananacabana>
From: "Chris Peterson" <chris@potamus.org>
To: <linux-kernel@vger.kernel.org>
Subject: [PROBLEM] "ls -R" freezes when using gnome-terminal on linux-2.6.0-test4
Date: Sun, 7 Sep 2003 11:37:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have discovered a regression between linux-2.4.20-8 (Redhat 9) and
linux-2.6.0-test4. I have not tried any other versions of linux-2.6.0-testX
or 2.5.x.

How to reproduce the problem:
1. Running GNOME on linux-2.6.0-test4, open two gnome-terminals.
2. In the first gnome-terminal, run "ls -R /" or "ls -R /dev" (you won't
have to wait as long :-).
3. In the second gnome-terminal, simply run "ls" (or just opening a
gnome-terminal window will sometimes cause the same problem).

Actual Results:
The ls in the first gnome-terminal will usually freeze. Neither CTRL+C nor
CTRL+Z will kill the ls process. The gnome-terminal itself is NOT frozen.
Its window menus are still responsive.

Expected Results:
ls should not freeze. The same steps on linux-2.4.20-8 (Redhat 9) do not
freeze ls. Running "ls -R /dev" on linux-2.6.0-test4 before starting X or
GNOME does not freeze ls either. So the problem seems to have something to
do with multiple interactive GNOME processes..?


chris

