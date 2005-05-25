Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVEYSir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVEYSir (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVEYSeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:34:31 -0400
Received: from ns1.heckrath.net ([213.239.205.18]:11938 "EHLO
	mail.heckrath.net") by vger.kernel.org with ESMTP id S262390AbVEYScB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:32:01 -0400
Date: Wed, 25 May 2005 21:34:19 +0200
From: Sebastian Kaergel <mailing@wodkahexe.de>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Error while reading /proc/acpi/battery/BAT1/state
Message-Id: <20050525213419.1c5af770.mailing@wodkahexe.de>
X-Mailer: Sylpheed version 1.9.11 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

installed 2.6.12-rc5 and noticed some strange behavior..

# while [ 1 ]; do cat /proc/acpi/battery/BAT1/state; done
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            0 mA
remaining capacity:      1840 mAh
present voltage:         14743 mV
<and so on...>

After a few second i get the following:

dswload-0294: *** Error: Looking up [PBST] in namespace,
AE_ALREADY_EXISTS

psparse-0601 [1606] ps_parse_loop         : During name lookup/catalog,
AE_ALREADY_EXISTS

psparse-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.BAT1._BST] (Node defc21e8), AE_ALREADY_EXISTS

acpi_battery-0208 [1599] acpi_battery_get_statu: Error evaluating _BST

osl-0958 [2167] os_wait_semaphore     : Failed to acquire semaphore
[de261d80|1|0], AE_TIME

osl-0958 [2203] os_wait_semaphore     : Failed to acquire semaphore
[de261d80|1|0], AE_TIME

and so on...

Machine is an Acer Travelmate 291lci laptop.
If you need other details, please let me know.

Thanks!
