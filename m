Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUHWDqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUHWDqG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 23:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUHWDqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 23:46:06 -0400
Received: from muttley.urbi.com.br ([200.152.58.27]:55254 "EHLO
	Muttley.urbi.com.br") by vger.kernel.org with ESMTP id S267353AbUHWDpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 23:45:49 -0400
Message-ID: <008601c488c3$a607dd30$21c3060a@nheotfd7dz4lxz>
From: "Alexandre" <almeida@urbi.com.br>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: wrong IDE disk size
Date: Mon, 23 Aug 2004 00:45:35 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Urbi-MailScanner: Found to be clean
X-MailScanner-From: almeida@urbi.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I installed two new SAMSUNG SP1203N (120GB) drives on the same IDE.
But, from the boot log:

hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 234493056 sectors (120060 MB) w/2048KiB Cache, CHS=14596/255/63,
UDMA(100)
hdd: attached ide-disk driver.
hdd: host protected area => 1
hdd: setmax_ext LBA 234493056, native  66055248
hdd: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=4111/255/63, UDMA(100)

So the second one get its capacity limited to ~33GB. I know there is a limit
of 34GB (CHS=4111/255/53) with older BIOSes and kernel, but i believe it
doesnt apply as the first drive got recognized properly. Also, i have
another 120 GB SEAGATE as hda working properly. (So the disk with wrong
capacity is the third IDE drive)

I'm running kernel 2.4.25. CONFIG_IDEDISK_STROKE is off.

Any ideas of what might be happening?
(I'd like to be personally CC'd  answers/comments)

Thanks in advance.


