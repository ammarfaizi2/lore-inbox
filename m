Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVDCFIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDCFIT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 00:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDCFIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 00:08:18 -0500
Received: from [67.177.11.57] ([67.177.11.57]:46720 "EHLO vger")
	by vger.kernel.org with ESMTP id S261198AbVDCFIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 00:08:15 -0500
Message-ID: <424F734D.4020203@soleranetworks.com>
Date: Sat, 02 Apr 2005 21:38:37 -0700
From: jmerkey <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.9 Adaptec Starfire sickness
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With linux 2.6.9 running at 192 MB/S network loading and protocol 
splitting drivers routing packets out of
a 2.6.9 device at full 100 mb/s (12.5 MB/S) simultaneously over 4 ports, 
the adaptec starfire driver goes into
constant Tx FIFO reconfiguration mode and after 3-4 days of constantly 
resetting the Tx FIFO window and
generating a deluge of messages such as:

ethX:  PCI bus congestion, resetting Tx FIFO window to X bytes

pouring into the system log file at a rate of a dozen per minute.  After 
several days, the PCI bus totally locks up
and hangs the system.  Need a config option to allow the starfire to 
disable this feature.  At very
high bus loading rates, the starfire card will completely lock the bus 
after 3-4 days
of constant Tx FIFO reconfiguration at very high data rates with 
protocol splitting and routing.

Jeff

