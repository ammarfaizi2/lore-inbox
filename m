Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTKTCCO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbTKTCCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:02:14 -0500
Received: from ns.schottelius.org ([213.146.113.242]:46525 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S264229AbTKTCCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:02:13 -0500
Date: Thu, 20 Nov 2003 03:02:18 +0100
From: Nico Schottelius <nico-mutt@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: transmeta cpu code question
Message-ID: <20031120020218.GJ3748@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

What does this do:

                printk(KERN_INFO "CPU: Processor revision %u.%u.%u.%u,
%u MHz\n",
                       (cpu_rev >> 24) & 0xff,
                       (cpu_rev >> 16) & 0xff,
                       (cpu_rev >> 8) & 0xff,
                       cpu_rev & 0xff,
                       cpu_freq);

(from arch/i386/kernel/cpu/transmeta.c)

Does not & 0xff make no sense? 0 & 1 makes 0, 1 & 1 makes 1, 
no changes.

And I don't understand why we do this for 8bit and shifting the
cpu_rev...

Can someone enlighten me (with CC' as I am not subscribed) ?

Nico
