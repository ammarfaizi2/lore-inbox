Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbULSWgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbULSWgE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 17:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbULSWgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 17:36:04 -0500
Received: from mailgate2.uni-paderborn.de ([131.234.22.35]:42981 "EHLO
	mailgate2.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S261345AbULSWgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 17:36:01 -0500
Date: Sun, 19 Dec 2004 23:37:36 +0100 (CET)
From: stefanb@upb.de
X-X-Sender: imp@kater
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: tun device doesn't report its device name
Message-ID: <Pine.LNX.4.61.0412192331081.5458@kater>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.715,
	required 4, AUTH_EIM_USER -5.00, NO_REAL_NAME 0.28)
X-MailScanner-From: stefanb@upb.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a problem with the virtual tun/tap device on my sparc64 (kernel 
2.6.9). I try to do:

struct ifreq ifr;
ifr.ifr_flags=IFF_TAP | IFF_NO_PI;
ioctl (dev, TUNSETIFF, &ifr);

After doing this I expect to find the name of the new interface in 
ifr.ifr_name. But it remains unchanged. ioctl's return value does not 
indicate an error. The device has actually been created (according to 
ifconfig).

The same piece of code works fine on my x86 machine.

Regards,
Stefan Boettner

