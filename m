Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUANCdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 21:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbUANCdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 21:33:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:19191 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S265649AbUANCds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 21:33:48 -0500
Date: Wed, 14 Jan 2004 11:29:30 +0900
From: Bharata B Rao <rao.bharata@samsung.com>
Subject: [2.6.1 PM] runtime device power management
To: linux-kernel@vger.kernel.org
Reply-to: rao.bharata@samsung.com
Message-id: <4004A98A.3020301@samsung.com>
Organization: Samsung Electronics
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been trying to suspend and resume a device in runtime using the 
/sys/devices/pci.../power/state interface.

First time the device suspend/resume works correctly.

But since, during resume the power_state is not set for the device(as is 
done during suspend), it still retains the old suspended state value.
Because of which, it can't be suspended again. (kernel thinks its 
already suspended)

This can be fixed by just setting the dev->power.power_state to 
appropriate value in drivers/base/power/runtime.c:runtime_resume() or in 
any other suitable place.

Regards,
Bharata.


