Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265916AbUGEEAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUGEEAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 00:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUGEEAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 00:00:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19938 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265916AbUGEEAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 00:00:18 -0400
Message-ID: <40E8D23F.9010400@pobox.com>
Date: Sun, 04 Jul 2004 23:59:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFP] better io-apic messages
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any janitor want to tackle this request-for-patch?  :)


There exists two problems:
a) default io-apic boot messages are quite verbose
b) io-apic bugs and anomalies are common enough that it would be nice to 
enable additional messages when the user requests them

My preferred solution is
apic=verbose -- enable verbose boot messages (seen in current kernels)
apic=debug -- enable all messages, including ones normally hidden by 
APIC_DEBUG

And the default, without any apic=xxx, would be not to show either set 
of messages.

This solution hides the messages for those who would rather not see 
them, but ensures they are available via a boot parameter when kernel 
developers wish to request additional debug info from a user.

