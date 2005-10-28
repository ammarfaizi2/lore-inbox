Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030617AbVJ1SmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030617AbVJ1SmF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030623AbVJ1SmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:42:05 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:51642 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030617AbVJ1SmE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:42:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=drnc1qo8Y3cjZ9vKlORCwl4B00zozJMHQy6QBxpt/nWhAl+DKhKIyHOfklyCR3drSiFRUOkHHmS+O11eAaJdkTAYTvR4omGaXoR8OCjMnyaS94PdFgrG7rGvAHTE5FA8ODO7er+OTgiUJ0axdjYS8Ztfg0PFAXCB7A/gFDxPif4=
Message-ID: <86802c440510281142i11771f25o3f6667869b4d614e@mail.gmail.com>
Date: Fri, 28 Oct 2005 11:42:03 -0700
From: Yinghai Lu <yinghai.lu@amd.com>
To: Andi Kleen <ak@suse.de>
Subject: x86_64: calibrate_delay_direct and apic id lift for BSP
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, linuxbios@openbios.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

I tried to lift apic id in LinuxBIOS for all cpus after 0x10.

When using MB with AMD8111, the jiffies was not moving. So it is
locked at calibrate_delay_direct...

but  MB with Nvidia ck804, jiffies is moving.

If I don't change BSP apic id ( keep it to 0), It changes....

I have no idea how the jiffies changes, there is another thread change it....?

YH


Memory: 508000k/524288k available (3146k kernel code, 15900k reserved,
1160k data, 296k init)
calibrate_delay_direct i=0
        calibrate_delay_direct start_jiffies=fffedb08
                calibrate_delay_direct 1 jiffies=fffedb08
                calibrate_delay_direct 1 jiffies=fffedb08
                calibrate_delay_direct 1 jiffies=fffedb08
                calibrate_delay_direct 1 jiffies=fffedb08
