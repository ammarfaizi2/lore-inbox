Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbTFDRhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTFDRhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:37:53 -0400
Received: from 12-221-81-65.client.insightBB.com ([12.221.81.65]:5124 "HELO
	apathy.killer-robot.net") by vger.kernel.org with SMTP
	id S263729AbTFDRhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:37:52 -0400
Date: Wed, 4 Jun 2003 12:51:21 -0500
From: Maciej <maciej@killer-robot.net>
To: linux-kernel@vger.kernel.org
Subject: orinoco_cs module removal problem
Message-ID: <20030604175121.GA1709@apathy.black-flower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just switched from 2.5.68 to 2.5.70, and I'm having trouble removing
the orinoco_cs module on the fly. After bringing the interface down,
doing an "rmmod orinoco_cs" causes the rmmod process to lock up, and
subseqeunt invocations of lsmod and 'cat /proc/modules' to do the same.
I get a bunch of messages like the following in the kernel log:

"unregister_netdevice: waiting for eth2 to become free. Usage count = 1

However, eth2, the orinoco device, no longer exists (it's not listed
in /proc/net/dev).

                             	 Maciej Babinski
