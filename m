Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWCZHvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWCZHvE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 02:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWCZHvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 02:51:04 -0500
Received: from noby.w34u.sk ([217.67.24.122]:61119 "HELO mail.w34u.sk")
	by vger.kernel.org with SMTP id S1751159AbWCZHvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 02:51:02 -0500
Message-ID: <442647E4.6080809@skalwifi.sk>
Date: Sun, 26 Mar 2006 09:51:00 +0200
From: Martin Petrak <martin.petrak@skalwifi.sk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: unregister_netdevice: waiting for ppp0 to become free
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am using kernel 2.6.14.6-grsec (x86_64 on AMD Sempron 64) with QoS (HTB)

Occasionally, when pppd drops a connection I see this in syslog :


Mar 25 13:40:17 myserver pppd[1300]: No response to 3 echo-requests
Mar 25 13:40:17 myserver pppd[1300]: Serial link appears to be disconnected.
Mar 25 13:40:17 myserver pppd[1300]: Connect time 1250.6 minutes.
Mar 25 13:40:17 myserver pppd[1300]: Sent 971616622 bytes, received 
1884313787 bytes.
Mar 25 13:40:20 myserver pppd[1300]: Connection terminated.
Mar 25 13:40:30 myserver kernel: unregister_netdevice: waiting for ppp0 
to become free. Usage count = 358

Then only force reboot of the machine solves the problem.

I found very similar problem with same symptoms :
http://groups.google.com/group/linux.debian.kernel/browse_thread/thread/dcb36b5fe827fad6/05445a30be147608

Do you have any ideas how I can debug why dev->refcnt did not reach zero?

regards,

Martin
