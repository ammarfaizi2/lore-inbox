Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264518AbUFJGqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbUFJGqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUFJGqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:46:03 -0400
Received: from imo-d02.mx.aol.com ([205.188.157.34]:25582 "EHLO
	imo-d02.mx.aol.com") by vger.kernel.org with ESMTP id S264518AbUFJGqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:46:00 -0400
Date: Thu, 10 Jun 2004 02:45:56 -0400
From: A1tmblwd@netscape.net
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3 Paul Slootman's floppy minor fix
MIME-Version: 1.0
Message-ID: <03AD23D8.67D3BCE2.005FFA64@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 24.6.81.222
X-AOL-Language: english
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul did not remove the superfluous variable 
initialization which masked the floppy minor bug in 
drivers/block/floppy.c.  Please add the patch below 
and close Bug 2770.


--- linux-2.6.7-rc3/drivers/block/floppy.c      2004-06-09 23:01:05.085675957 -0700
+++ linux-2.6.7-rc3/drivers/block/floppy.c      2004-06-09 23:06:36.889119454 -0700
@@ -4228,7 +4228,6 @@
        int err, dr;
                                                                                                 
        raw_cmd = NULL;
-       i = 0;
                                                                                                 
        for (dr = 0; dr < N_DRIVE; dr++) {
                disks[dr] = alloc_disk(1);



Regards,

Kam Leo


__________________________________________________________________
Introducing the New Netscape Internet Service. 
Only $9.95 a month -- Sign up today at http://isp.netscape.com/register

Netscape. Just the Net You Need. 

New! Netscape Toolbar for Internet Explorer
Search from anywhere on the Web and block those annoying pop-ups.
Download now at http://channels.netscape.com/ns/search/install.jsp
