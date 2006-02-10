Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWBJOQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWBJOQu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWBJOQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:16:50 -0500
Received: from smtp.enternet.hu ([62.112.192.21]:43276 "EHLO smtp.enternet.hu")
	by vger.kernel.org with ESMTP id S932097AbWBJOQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:16:49 -0500
Message-ID: <00af01c62e4d$8de8c6c0$9d00a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: netconsole problem
Date: Fri, 10 Feb 2006 15:23:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list,

I have a little problem, with netconsole.
It does not work for me.

On the "client":

modprobe netconsole netconsole=@/,514@192.168.2.100/
dmesg:
netconsole: local port 6665
netconsole: interface eth0
netconsole: remote port 514
netconsole: remote IP 192.168.2.100
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
netconsole: local IP 192.168.2.50
netconsole: network logging started

(kernel: 2.6.15-rc5, and 2.6.16-rc1,2)

On the server:
]# netcat -u -l -v -s 192.168.2.100 -p 514
192.168.2.100: inverse host lookup failed: Unknown host
listening on [192.168.2.100] 514 ...

And nothing comes.

The firewall is off on both system.
The ping comes from any direction.

If i try the remote and local syslog, it works well, two.
And in this case, the netlog only displays what the syslog is sends.

What can be the problem?

Thanks,
Janos
