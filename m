Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWAaOtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWAaOtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 09:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWAaOtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 09:49:49 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:20682 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750888AbWAaOts convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 09:49:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A7mf8WIWvBfGVLvd+WwiiiXt3dFqwLrt0GOB/Knw89HgiFUIZvUUcruJQm4MgL/kUX9L00DKljrx/BmEqjOHQJo07YwwMdcwY5j6K02kjan/l9W0DY2MltO/8yfqh3sgrCbCy0NX1ZrKkoTpQxNy+ruRPWPeFvNh+CPl/hJdMNg=
Message-ID: <c2f233c10601310649j6b104787m5a2287d3e022a911@mail.gmail.com>
Date: Tue, 31 Jan 2006 20:19:47 +0530
From: Vinod KK <kkvinod@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_PREEMPT_SOFTIRQS
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using linux 2.6.10 (with Ingo Molnars real time patches) on my mips board.

When I try running high network traffic (10% traffic on a 100Mbps
link) on my target board with the CONFIG_PREEMPT_DESKTOP=y and
CONFIG_PREEMPT_SOFTIRQS=y options enabled I notice that the console
freezes and recovers only after the traffic stops. I do not notice
this behaviour with the CONFIG_PREEMPT_SOFTIRQS option disabled.

I understand that the CONFIG_PREEMPT_SOFTIRQS option puts all softirq
processing to the ksoftirqd daemon, but i do not see why this should
stall the console. I believe there should be some task which is
starving for CPU, but I do not know which one.

The console is on an 16550 serial port.

Could someone please give me some pointers on where I should start looking?

Thanks,
Vinod K.
