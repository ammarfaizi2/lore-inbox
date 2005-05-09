Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVEIURD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVEIURD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 16:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVEIURD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 16:17:03 -0400
Received: from p4.gsnoc.net ([209.51.147.210]:44198 "EHLO p4.gsnoc.net")
	by vger.kernel.org with ESMTP id S261508AbVEIURA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 16:17:00 -0400
Message-ID: <427FC554.1070306@cachola.com.br>
Date: Mon, 09 May 2005 17:17:24 -0300
From: =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= <andre@cachola.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: acpi poweroff
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p4.gsnoc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - cachola.com.br
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to poweroff my computer, it reboots.
The only way to turn it off is to change

acpi_sleep_prepare(ACPI_STATE_S5);

to

acpi_sleep_prepare(ACPI_STATE_S4);

in the function acpi_power_off in the file drivers/acpi/sleep/poweroff.c.
I think it's a buggy acpi controller.
What's the side effect of this change?
