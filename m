Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965398AbWJ2UTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398AbWJ2UTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965400AbWJ2UTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:19:11 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37035 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965398AbWJ2UTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:19:10 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45450CA1.3000008@s5r6.in-berlin.de>
Date: Sun, 29 Oct 2006 21:18:41 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: Ben Collins <bcollins@ubuntu.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: Re: [rfc patch] ieee1394: nodemgr: revise semaphore protection of
 driver core data
References: <tkrat.2407a13c0fa37837@s5r6.in-berlin.de> <tkrat.dc92ad51062d41bb@s5r6.in-berlin.de>
In-Reply-To: <tkrat.dc92ad51062d41bb@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote on 2006-10-22:
[I wrote on 2006-10-22:
|| This may or may not be related to
|| https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188140
|| (System freezes while hald is accessing FireWire sysfs data.)
]
No, it's certainly unrelated. In the meantime the problem was also
encountered if the same device was connected via USB.

> # modprobe -r ohci1394
> Segmentation fault
...
> Oct 22 17:24:08 shuttle kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000002c
...
> Oct 22 17:24:08 shuttle kernel: EIP is at klist_del+0x14/0x50
...

Since then the oops did never happen under 2.6.18.1 plus this patch and
other ieee1394 updates. I.e. that one was certainly a problem in
2.6.19-rc2. I will continue testing on 2.6.19-rcX.
-- 
Stefan Richter
-=====-=-==- =-=- ===-=
http://arcgraph.de/sr/
