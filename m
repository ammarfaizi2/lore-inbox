Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTE0KqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTE0KqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:46:14 -0400
Received: from [213.229.38.66] ([213.229.38.66]:28290 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S263219AbTE0KqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:46:13 -0400
Message-ID: <3ED34528.90702@winischhofer.net>
Date: Tue, 27 May 2003 12:59:52 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: SiS USB IRQ (Was: [patch] sis650 irq router fix for 2.4.x)
References: <3ED21CE3.9060400@winischhofer.net> <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not relevant to the 650, but for the 630: Going through the datasheet 
revealed that the 630 (with built-in Super South Bridge) does not know 
register 0x62 (of the "ISA bridge", speak the irq router, 00:01.0, 
1039:0008, revision 0) - it's reserved there, but the datasheets states 
explicitly that bit 7 should be set to 1.

The USB interrupts and their routing is determined by bit 8 register 
0x04 of the USB OHCI configuration space (00:01.2 and 00:01.3).

Perhaps some interrupt guru knows what to do with this information and 
is able to verify that the current implementation does this right...

Thomas


-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org



