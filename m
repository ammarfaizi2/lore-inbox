Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbTLCSrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 13:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbTLCSrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 13:47:05 -0500
Received: from stinkfoot.org ([65.75.25.34]:2694 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S265109AbTLCSrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 13:47:03 -0500
Message-ID: <3FCE2F8E.90104@stinkfoot.org>
Date: Wed, 03 Dec 2003 13:46:38 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HT apparently not detected properly on 2.4.23
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.4.22, my Supermicro X5DPL-iGM-O (E7501 chipset) with 2 
xeons@2.4ghz and hypertherading enabled shows 4 cpu's in 
/proc/cpuinfo|proc/interrupts, with:
CONFIG_ACPI=y
CONFIG_ACPI_HT_ONLY=y
The same config with 2.4.23 only shows 2 cpus, even with:
CONFIG_NR_CPUS=4

Also, I believe this has been reported before, but the system only seems 
to interrupt on CPU0 with either kernel, unless I apply a patch I found 
here:
http://www.hardrock.org/kernel/2.4.22/irqbalance-2.4.22-MRC.patch
or run the `irqbalance' program.. which I don't care to do.  This 
problem _seems_ to be isolated to the Supermicro, as HT does seem 
properly detected on several other SMP systems I have at work (compaq 
ML370/ML380) with 2.4.23

-Ethan

