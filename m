Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262991AbUKRVbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbUKRVbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKRVbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:31:07 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:4573 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261161AbUKRV3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:29:46 -0500
Message-ID: <419D1443.9080807@nortelnetworks.com>
Date: Thu, 18 Nov 2004 15:29:39 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Tomas Carnecky <tom@dbservice.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
References: <200411181859.27722.gjwucherpfennig@gmx.net> <419CFF73.3010407@dbservice.com> <Pine.LNX.4.53.0411182146060.29376@yvahk01.tjqt.qr> <419D10DF.4040902@nortelnetworks.com> <Pine.LNX.4.53.0411182216160.16465@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411182216160.16465@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

> For CPUs which don't have some sort of speedstep, it does not matter.
> (Please correct me if I am wrong. It might be that HLT cycles are still more
> power-conservative even without speedstep than 24/7 on the FPU.)

Actually, it does matter.  Transistors that aren't being used don't consume 
power.  So if you just sit spinning on hlt, you don't use a lot of the chip, and 
you use less power.  This is why overclockers will test their cooling solutions 
while running the cpu at full throttle with various stress tests.

Aside from the cpu itself, when idling you also don't consume memory bus cycles, 
you never hit the network, you don't use the disk, etc., etc.  It all adds up.

Chris
