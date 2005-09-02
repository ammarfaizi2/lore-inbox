Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030643AbVIBCDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030643AbVIBCDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 22:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbVIBCDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 22:03:21 -0400
Received: from [210.76.114.20] ([210.76.114.20]:47298 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1030643AbVIBCDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 22:03:21 -0400
Message-ID: <4317B309.3000404@ccoss.com.cn>
Date: Fri, 02 Sep 2005 10:03:53 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Q] how to use syslogd to debug kernel ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone.

    I know kernel oops can be seen by run 'dmesg', but if
kernel crashed, we can not run it.   so I reconfigure syslogd
to support remote forward, the debug machine content of
syslogd.conf is:

##################
    kern.*             @192.168.28.137
    (more lines after it are ignored)
##################

    and run syslogd with '-m 0 -h' option.

    the macheine have IP 192.168.28.137, its syslogd.conf:

##################
    #kern.*            /var/messages
    (more lines after it are ignored)  
##################

    and I run syslogd on this machine with '-r' option.

    After all, I run "tail -f /var/messages" on 192.168.28.137,
I can see boot log and normal printk() result. Well! however,
the most importantest message, crash Oops is lost.

    Any suggest on it?

    Wait for any reply. thanks in advanced.


sailor









