Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267506AbUHPKM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267506AbUHPKM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267510AbUHPKM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:12:56 -0400
Received: from gw-oleane.hubxpress.net ([81.80.52.129]:23505 "EHLO
	yoda.hubxpress.net") by vger.kernel.org with ESMTP id S267506AbUHPKMp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:12:45 -0400
From: "Sylvain COUTANT" <sylvain.coutant@illicom.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>, <riel@redhat.com>, <andrea@suse.de>
Subject: RE: High CPU usage (up to server hang) under heavy I/O load
Date: Mon, 16 Aug 2004 12:11:48 +0200
Organization: ILLICOM
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040813162018.GB29292@logos.cnet>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcSBXhRCgfKy+w6USDGgDhs63iBGowCGXQ1g
Message-Id: <20040816101241.6315F2FC2C@illicom.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcello,

> You want to try this

The server now runs 2.4.26 with the patch applied for about two hours. I
have triggered backups so that it is a little bit stressed.

My first feeling is something changed. Once the whole physical memory has
been in use by the kernel, I saw some load problems rising (as before), but
the server did not hang (as before ;-) and system load has gone down
smoothly (took about one or two minutes).

Now it looks stable under medium I/O load. I'll give it more stress next
night and I'll report the behaviour here.

However, kswapd is still a major CPU eater : 5 minutes of CPU time consumed
since the reboot (2 hours). kupdated is at 1 minute and bdflush is 12
seconds. /proc/sys/vm are boot time standard settings with no change. Actual
system load is near 4 for 15 minutes average, which I consider very bad
result regarding currently running application. I believe I should be near 1
...


Do you think I could achieve better results (smoother operations) by
tweaking those /proc/sys/vm settings ?


Regards,
Sylvain.

