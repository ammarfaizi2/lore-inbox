Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUKHRbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUKHRbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbUKHROL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:14:11 -0500
Received: from smtp-4.vancouver.ipapp.com ([216.152.192.207]:59798 "EHLO
	envitech.com") by vger.kernel.org with ESMTP id S261937AbUKHQlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:41:37 -0500
Message-ID: <418FA1DB.4060207@envitech.com>
Date: Mon, 08 Nov 2004 11:42:03 -0500
From: Richard Brunelle <rbrunelle@envitech.com>
Reply-To: rbrunelle@envitech.com
Organization: Envitech Automation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Calibrating delay crash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Rcpt-To: <linux-kernel@vger.kernel.org>
X-Country: CA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please put me in CC when replying)

I'm having trouble booting a PentiumMMX @ 266 MHz board with 64 Mbytes 
of RAM. The kernel crashes while in the main.c/calibrate_delay function. 
It never boot, sometimes it fails and reboot, sometimes a page fault 
occured. I tried with the kernels 2.4.21, 2.4.26 and 2.6.7 with the same 
results.

I notice that if I return before the calibration loop, the system boots 
fine. This has been tried only for testing.

void __init calibrate_delay(void)
{
    unsigned long ticks, loopbit;
    int lps_precision = LPS_PREC;

    loops_per_jiffy = (1<<12);

return; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    printk("Calibrating delay loop... ");
....

I look in the archive and one post points to a memory problem, I ran 
memtest86 with no error found. Now I wonder what can cause this problem, 
is it a hardware issue/timing? What can I do to investigate more? How 
the calibrate_delay loop can crash the kernel?

Thanks.




