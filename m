Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbUL2Ox6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUL2Ox6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 09:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbUL2Ox6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 09:53:58 -0500
Received: from smtp.telefonica.net ([213.4.129.135]:34522 "EHLO
	tnetsmtp2.mail.isp") by vger.kernel.org with ESMTP id S261352AbUL2Oxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 09:53:48 -0500
Message-ID: <41D2C4FA.7010806@telefonica.net>
Date: Wed, 29 Dec 2004 15:53:46 +0100
From: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 resuming laptop from suspension f*cks usb subsystem
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from the timer drift thingie, 2.6.10 brought some new features 
like usb devices (ramdomly) not working after resuming from suspend mode.

In 2.6.9 usb worked well, resuming from suspend just throws a bunch 
(near 20) messages like:

    drivers/usb/input/hid-core.c: input irq status -84 received

(getting form /var/log/syslog, just don't have time to switch back to 
2.6.9 and fiddle with it again). After those messages, the usb subsystem 
comes stable again and worked like a charm.

In 2.6.10, resuming from suspend mode just (randomly) crashes the USB 
subsystem, and I get the same messages (not sure about the whole message 
but the "-84" part really is there) over and over again until I reboot.
