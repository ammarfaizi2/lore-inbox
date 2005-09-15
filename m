Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVIOLsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVIOLsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVIOLsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:48:11 -0400
Received: from admin.opoint.com ([193.90.144.98]:27266 "HELO mail.opoint.com")
	by vger.kernel.org with SMTP id S1751107AbVIOLsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:48:10 -0400
Message-ID: <43295F60.6050303@opoint.com>
Date: Thu, 15 Sep 2005 13:47:44 +0200
From: Joakim Tysseng <joakim.tysseng@opoint.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: XFS lockup on 2.6.12-1.1376_FC3smp
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing a serious problem with XFS on 2.6.12-1.1376_FC3smp

The filesystem locks up (no write possible, mysql won't shut down, 
impossible to reboot machine from console) while running MySQL under a 
high load. The only error messages I can find are:

thales kernel: allocation failed: out of vmalloc space - use 
vmalloc=<size> to increase size.
thales kernel: XFS: possible memory allocation deadlock in kmem_alloc 
(mode:0x250

I've tried increasing /proc/sys/vm/min_free_kbytes to 16386 without success.

Any ideas? Where should I start looking, what logs, programs/tests can i 
run?

The problem does not appear immediately, the shortest time from reboot 
to failure has been 4 hours.

Machine config:
Dell 6650 / 4 x P4 Xeon with 12GB ram.
1.5T SCSI disk array / PW220S / Perc 4/DC
running XFS on top of LVM.
--
Sincerely,
Joakim Tysseng
