Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753075AbWKLUbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbWKLUbY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 15:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbWKLUbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 15:31:24 -0500
Received: from mail.ggsys.net ([69.26.161.131]:2190 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S1753075AbWKLUbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 15:31:23 -0500
Subject: Re: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4556AC74.3010000@rtr.ca>
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>
	 <1163180185.28843.13.camel@w100>  <4556AC74.3010000@rtr.ca>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Sun, 12 Nov 2006 14:31:19 -0600
Message-Id: <1163363479.3423.8.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, after adding the printk line I can start seeing
results.

I guess it has been close to 10 on quite a few
occasions.

Thanks,

Alberto

# grep qstor /var/log/messages
Nov 12 07:00:53 w100 kernel: sata_qstor: spurious=0
Nov 12 07:00:53 w100 kernel: sata_qstor: spurious=1
Nov 12 07:00:53 w100 kernel: sata_qstor: spurious=0
Nov 12 07:00:56 w100 kernel: sata_qstor: spurious=1
Nov 12 07:00:56 w100 kernel: sata_qstor: spurious=2
Nov 12 07:00:56 w100 kernel: sata_qstor: spurious=0
Nov 12 07:03:35 w100 kernel: sata_qstor: spurious=0
Nov 12 07:34:44 w100 kernel: sata_qstor: spurious=0
Nov 12 07:35:08 w100 kernel: sata_qstor: spurious=1
Nov 12 07:35:08 w100 kernel: sata_qstor: spurious=1
Nov 12 07:35:08 w100 kernel: sata_qstor: spurious=0
Nov 12 09:11:17 w100 kernel: sata_qstor: spurious=0
Nov 12 09:11:17 w100 kernel: sata_qstor: spurious=1
Nov 12 09:11:17 w100 kernel: sata_qstor: spurious=0
Nov 12 09:11:17 w100 kernel: sata_qstor: spurious=1
Nov 12 09:11:18 w100 kernel: sata_qstor: spurious=0
Nov 12 09:36:34 w100 kernel: sata_qstor: spurious=0
Nov 12 09:38:26 w100 kernel: sata_qstor: spurious=0
Nov 12 09:38:26 w100 kernel: sata_qstor: spurious=0
Nov 12 09:53:06 w100 kernel: sata_qstor: spurious=0
Nov 12 09:53:06 w100 kernel: sata_qstor: spurious=1
Nov 12 09:53:06 w100 kernel: sata_qstor: spurious=2
Nov 12 09:53:06 w100 kernel: sata_qstor: spurious=0
Nov 12 09:53:09 w100 kernel: sata_qstor: spurious=1
Nov 12 10:09:03 w100 kernel: sata_qstor: spurious=0
Nov 12 10:09:04 w100 kernel: sata_qstor: spurious=1
Nov 12 10:09:05 w100 kernel: sata_qstor: spurious=0
Nov 12 10:09:05 w100 kernel: sata_qstor: spurious=0
Nov 12 10:11:52 w100 kernel: sata_qstor: spurious=0
Nov 12 10:11:53 w100 kernel: sata_qstor: spurious=1
Nov 12 10:11:53 w100 kernel: sata_qstor: spurious=2
Nov 12 10:11:53 w100 kernel: sata_qstor: spurious=3
Nov 12 10:11:54 w100 kernel: sata_qstor: spurious=0
Nov 12 10:11:55 w100 kernel: sata_qstor: spurious=1
Nov 12 10:11:55 w100 kernel: sata_qstor: spurious=0
Nov 12 10:12:35 w100 kernel: sata_qstor: spurious=1
Nov 12 10:12:37 w100 kernel: sata_qstor: spurious=0
Nov 12 10:12:37 w100 kernel: sata_qstor: spurious=1
Nov 12 10:12:37 w100 kernel: sata_qstor: spurious=0
Nov 12 10:30:51 w100 kernel: sata_qstor: spurious=0
Nov 12 10:30:51 w100 kernel: sata_qstor: spurious=1
Nov 12 10:30:51 w100 kernel: sata_qstor: spurious=2
Nov 12 10:30:52 w100 kernel: sata_qstor: spurious=0
Nov 12 10:30:52 w100 kernel: sata_qstor: spurious=0
Nov 12 10:40:08 w100 kernel: sata_qstor: spurious=0
Nov 12 10:40:08 w100 kernel: sata_qstor: spurious=1
Nov 12 10:57:34 w100 kernel: sata_qstor: spurious=0
Nov 12 10:57:34 w100 kernel: sata_qstor: spurious=1
Nov 12 10:57:34 w100 kernel: sata_qstor: spurious=1
Nov 12 10:57:34 w100 kernel: sata_qstor: spurious=0
Nov 12 10:57:37 w100 kernel: sata_qstor: spurious=0
Nov 12 10:57:37 w100 kernel: sata_qstor: spurious=1
Nov 12 10:57:37 w100 kernel: sata_qstor: spurious=2
Nov 12 10:57:37 w100 kernel: sata_qstor: spurious=3
Nov 12 10:57:37 w100 kernel: sata_qstor: spurious=4
Nov 12 10:57:37 w100 kernel: sata_qstor: spurious=5
Nov 12 10:57:37 w100 kernel: sata_qstor: spurious=3
Nov 12 11:01:18 w100 kernel: sata_qstor: spurious=0
Nov 12 11:01:19 w100 kernel: sata_qstor: spurious=1
Nov 12 11:18:35 w100 kernel: sata_qstor: spurious=0
Nov 12 11:18:39 w100 kernel: sata_qstor: spurious=1
Nov 12 11:18:40 w100 kernel: sata_qstor: spurious=0
Nov 12 11:18:40 w100 kernel: sata_qstor: spurious=0
Nov 12 11:21:42 w100 kernel: sata_qstor: spurious=0
Nov 12 11:35:11 w100 kernel: sata_qstor: spurious=0
Nov 12 11:35:11 w100 kernel: sata_qstor: spurious=1
Nov 12 11:35:11 w100 kernel: sata_qstor: spurious=0
Nov 12 11:35:12 w100 kernel: sata_qstor: spurious=0
Nov 12 11:35:12 w100 kernel: sata_qstor: spurious=1
Nov 12 11:35:12 w100 kernel: sata_qstor: spurious=2
Nov 12 11:35:12 w100 kernel: sata_qstor: spurious=3
Nov 12 11:35:12 w100 kernel: sata_qstor: spurious=4
Nov 12 11:35:12 w100 kernel: sata_qstor: spurious=2
Nov 12 11:38:01 w100 kernel: sata_qstor: spurious=0
Nov 12 11:38:01 w100 kernel: sata_qstor: spurious=1
Nov 12 11:38:01 w100 kernel: sata_qstor: spurious=0
Nov 12 11:42:53 w100 kernel: sata_qstor: spurious=0
Nov 12 11:50:26 w100 kernel: sata_qstor: spurious=0
Nov 12 11:50:26 w100 kernel: sata_qstor: spurious=1
Nov 12 11:50:26 w100 kernel: sata_qstor: spurious=2
Nov 12 11:50:26 w100 kernel: sata_qstor: spurious=0
Nov 12 12:07:03 w100 kernel: sata_qstor: spurious=0
Nov 12 12:07:03 w100 kernel: sata_qstor: spurious=0
Nov 12 12:07:03 w100 kernel: sata_qstor: spurious=1
Nov 12 12:07:03 w100 kernel: sata_qstor: spurious=2
Nov 12 12:07:11 w100 kernel: sata_qstor: spurious=0
Nov 12 12:07:11 w100 kernel: sata_qstor: spurious=1
Nov 12 12:07:11 w100 kernel: sata_qstor: spurious=0
Nov 12 12:15:08 w100 kernel: sata_qstor: spurious=0
Nov 12 12:15:31 w100 kernel: sata_qstor: spurious=1
Nov 12 12:15:31 w100 kernel: sata_qstor: spurious=0
Nov 12 12:15:31 w100 kernel: sata_qstor: spurious=1
Nov 12 12:15:31 w100 kernel: sata_qstor: spurious=2
Nov 12 12:41:11 w100 kernel: sata_qstor: spurious=0
Nov 12 12:41:28 w100 kernel: sata_qstor: spurious=1
Nov 12 12:41:28 w100 kernel: sata_qstor: spurious=2
Nov 12 12:41:28 w100 kernel: sata_qstor: spurious=3
Nov 12 12:41:28 w100 kernel: sata_qstor: spurious=4
Nov 12 12:41:28 w100 kernel: sata_qstor: spurious=5
Nov 12 12:41:28 w100 kernel: sata_qstor: spurious=3
Nov 12 13:05:42 w100 kernel: sata_qstor: spurious=0
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=1
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=2
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=3
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=4
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=5
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=6
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=6
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:47 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=0
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=1
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=2
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=3
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=4
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=5
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=6
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=6
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=7
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=8
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=9
Nov 12 13:05:52 w100 kernel: sata_qstor: spurious=0
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=1
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=2
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=3
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=4
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=5
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=6
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=7
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=8
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=8
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=8
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=8
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=6
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=0
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=1
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=0
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=1
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=2
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=3
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=4
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=5
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=6
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=7
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=8
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=8
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=8
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=7
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=8
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=4
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=5
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=6
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=7
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=8
Nov 12 13:06:01 w100 kernel: sata_qstor: spurious=9
Nov 12 13:20:15 w100 kernel: sata_qstor: spurious=0
Nov 12 13:20:15 w100 kernel: sata_qstor: spurious=1
Nov 12 13:20:15 w100 kernel: sata_qstor: spurious=2
Nov 12 13:20:17 w100 kernel: sata_qstor: spurious=0
Nov 12 13:20:17 w100 kernel: sata_qstor: spurious=1
Nov 12 13:20:17 w100 kernel: sata_qstor: spurious=0
Nov 12 13:23:30 w100 kernel: sata_qstor: spurious=0
Nov 12 13:23:30 w100 kernel: sata_qstor: spurious=1
Nov 12 13:23:30 w100 kernel: sata_qstor: spurious=2
Nov 12 13:23:30 w100 kernel: sata_qstor: spurious=3
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=0
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=0
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=1
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=0
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=0
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=1
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=1
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=2
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=0
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=1
Nov 12 13:23:36 w100 kernel: sata_qstor: spurious=2
Nov 12 13:24:08 w100 kernel: sata_qstor: spurious=0
Nov 12 13:24:08 w100 kernel: sata_qstor: spurious=1
Nov 12 13:24:08 w100 kernel: sata_qstor: spurious=1
Nov 12 13:24:08 w100 kernel: sata_qstor: spurious=0
Nov 12 13:26:36 w100 kernel: sata_qstor: spurious=0
Nov 12 13:26:36 w100 kernel: sata_qstor: spurious=0
Nov 12 13:26:36 w100 kernel: sata_qstor: spurious=1
Nov 12 13:26:36 w100 kernel: sata_qstor: spurious=2
Nov 12 13:31:30 w100 kernel: sata_qstor: spurious=0
Nov 12 13:31:33 w100 kernel: sata_qstor: spurious=1
Nov 12 13:31:33 w100 kernel: sata_qstor: spurious=1
Nov 12 13:32:18 w100 kernel: sata_qstor: spurious=0
Nov 12 13:32:43 w100 kernel: sata_qstor: spurious=1
Nov 12 13:32:43 w100 kernel: sata_qstor: spurious=2
Nov 12 13:32:43 w100 kernel: sata_qstor: spurious=3
Nov 12 13:32:43 w100 kernel: sata_qstor: spurious=3
Nov 12 13:33:07 w100 kernel: sata_qstor: spurious=0
Nov 12 13:33:07 w100 kernel: sata_qstor: spurious=1
Nov 12 13:33:07 w100 kernel: sata_qstor: spurious=2
Nov 12 13:33:07 w100 kernel: sata_qstor: spurious=3
Nov 12 13:33:07 w100 kernel: sata_qstor: spurious=4
Nov 12 13:33:07 w100 kernel: sata_qstor: spurious=2
Nov 12 13:33:08 w100 kernel: sata_qstor: spurious=0
Nov 12 13:33:39 w100 kernel: sata_qstor: spurious=0
Nov 12 13:34:53 w100 kernel: sata_qstor: spurious=0
Nov 12 13:34:53 w100 kernel: sata_qstor: spurious=1
Nov 12 13:34:53 w100 kernel: sata_qstor: spurious=0
Nov 12 13:41:15 w100 kernel: sata_qstor: spurious=0
Nov 12 13:41:15 w100 kernel: sata_qstor: spurious=1
Nov 12 13:41:19 w100 kernel: sata_qstor: spurious=0
Nov 12 13:41:19 w100 kernel: sata_qstor: spurious=1
Nov 12 13:41:19 w100 kernel: sata_qstor: spurious=2
Nov 12 13:41:19 w100 kernel: sata_qstor: spurious=3
Nov 12 13:41:19 w100 kernel: sata_qstor: spurious=4
Nov 12 13:41:19 w100 kernel: sata_qstor: spurious=5
Nov 12 13:41:19 w100 kernel: sata_qstor: spurious=3
Nov 12 13:49:43 w100 kernel: sata_qstor: spurious=0
Nov 12 13:49:43 w100 kernel: sata_qstor: spurious=0
Nov 12 13:49:43 w100 kernel: sata_qstor: spurious=1
Nov 12 13:49:43 w100 kernel: sata_qstor: spurious=2
Nov 12 13:49:49 w100 kernel: sata_qstor: spurious=0
Nov 12 13:49:49 w100 kernel: sata_qstor: spurious=0
Nov 12 13:49:49 w100 kernel: sata_qstor: spurious=1
Nov 12 13:49:49 w100 kernel: sata_qstor: spurious=2
Nov 12 13:53:04 w100 kernel: sata_qstor: spurious=0
Nov 12 13:53:32 w100 kernel: sata_qstor: spurious=0
Nov 12 13:53:32 w100 kernel: sata_qstor: spurious=1
Nov 12 13:53:32 w100 kernel: sata_qstor: spurious=0
Nov 12 13:56:11 w100 kernel: sata_qstor: spurious=0
Nov 12 13:56:11 w100 kernel: sata_qstor: spurious=0
Nov 12 13:56:11 w100 kernel: sata_qstor: spurious=1
Nov 12 13:56:11 w100 kernel: sata_qstor: spurious=2
Nov 12 13:56:11 w100 kernel: sata_qstor: spurious=0
Nov 12 13:56:11 w100 kernel: sata_qstor: spurious=0
Nov 12 13:56:11 w100 kernel: sata_qstor: spurious=1
Nov 12 13:56:11 w100 kernel: sata_qstor: spurious=2
Nov 12 13:56:13 w100 kernel: sata_qstor: spurious=0
Nov 12 13:56:13 w100 kernel: sata_qstor: spurious=0
Nov 12 14:10:49 w100 kernel: sata_qstor: spurious=0
Nov 12 14:10:49 w100 kernel: sata_qstor: spurious=1
Nov 12 14:10:49 w100 kernel: sata_qstor: spurious=0
Nov 12 14:10:50 w100 kernel: sata_qstor: spurious=1
Nov 12 14:10:50 w100 kernel: sata_qstor: spurious=1
Nov 12 14:10:50 w100 kernel: sata_qstor: spurious=0
Nov 12 14:11:40 w100 kernel: sata_qstor: spurious=0
Nov 12 14:11:40 w100 kernel: sata_qstor: spurious=1
Nov 12 14:11:40 w100 kernel: sata_qstor: spurious=2
Nov 12 14:11:40 w100 kernel: sata_qstor: spurious=3
Nov 12 14:14:32 w100 kernel: sata_qstor: spurious=0
Nov 12 14:14:32 w100 kernel: sata_qstor: spurious=0
Nov 12 14:14:32 w100 kernel: sata_qstor: spurious=1
Nov 12 14:14:32 w100 kernel: sata_qstor: spurious=1
Nov 12 14:14:32 w100 kernel: sata_qstor: spurious=0
Nov 12 14:22:18 w100 kernel: sata_qstor: spurious=0
Nov 12 14:22:22 w100 kernel: sata_qstor: spurious=1
Nov 12 14:22:22 w100 kernel: sata_qstor: spurious=2
Nov 12 14:22:22 w100 kernel: sata_qstor: spurious=3
Nov 12 14:26:51 w100 kernel: sata_qstor: spurious=0
Nov 12 14:26:51 w100 kernel: sata_qstor: spurious=1
Nov 12 14:26:51 w100 kernel: sata_qstor: spurious=0



On Sun, 2006-11-12 at 00:09 -0500, Mark Lord wrote:
> Alberto Alonso wrote:
> > The saga continues. It happened again this morning even with the
> > patch:
> ..
> >> Mmm.. We could apply a bit of fuzzy tolerance for the odd glitch.
> >> Try this patch (attached) and report back.
> 
> Did you add the printk() to the patch, as suggested?
> If so, did it log anything ?
> 
> Thanks
-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

