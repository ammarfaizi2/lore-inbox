Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUAUWIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 17:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUAUWIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 17:08:05 -0500
Received: from pasta.sw.starentnetworks.com ([12.33.234.10]:19678 "EHLO
	pasta.sw.starentnetworks.com") by vger.kernel.org with ESMTP
	id S266181AbUAUWIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 17:08:01 -0500
Date: Wed, 21 Jan 2004 17:08:00 -0500
From: Brian Ristuccia <bristucc@sw.starentnetworks.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 CONFIG_NUMA=y leads to random segfaults
Message-ID: <20040121220800.GO5555@sw.starentnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While building a kernel for a Dual Athlon MP 2800 system, I accidentally
enabled CONFIG_NUMA, "Numa Memory Allocation Support". This option should
have been a no-op on the system I was using it on, since on this motherboard
all system memory is equally close to each of the two CPU's. Instead, it
caused userspace processes to randomly segfault.

Booting a 2.6.0 rebuilt without CONFIG_NUMA made the problem go away.

-- 
Brian Ristuccia
bristucc@sw.starentnetworks.com
