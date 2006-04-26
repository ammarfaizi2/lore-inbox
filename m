Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWDZXe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWDZXe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWDZXe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:34:56 -0400
Received: from 8.ctyme.com ([69.50.231.8]:48873 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751164AbWDZXe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:34:56 -0400
Message-ID: <4450039F.20704@perkel.com>
Date: Wed, 26 Apr 2006 16:34:55 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A Question for the Worlds Smartest Network Minds
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this question isn't too far off topic but I'm having a very weird 
network problem and don't know where to ask it. Perhaps someone could 
point me in the right direction. I have an unusual packet loss problem 
that has me stumped.

Working at home with a cable modem connected to a Linksys WRT54G router. 
Behind the router are two computers. One is a Linux server and a windows 
XP notebook.

The Linux box is accessable to the outside world because I opened 3 
ports in the NAT. Port 22,25,and 53. The server acts as a name server 
for the domains I host and it also is a backup spam filtering server 
receiving many incomming connections on port 25 and sending out far less 
good email also on port 25 to various other server who I am the front 
ens spam filter for.

Linux box is running FC5 with the latest stock FC5 kernel. Some flavor 
of 2.6.16.

Here's the problem. I can ping the router gateway 192.168.2.1 fine from 
both computers with no packet loss if I turn off the Exim SMTP daemon. 
But if I turn it on then I get about 10% packet loss pinging the gateway 
on both the Linux and Windows computers, both plugged into the Linksys 
router.

Thinking it might be the quantity of traffic I tried uploading a large 
file with rsync ovser SSH which creates a lot more traffic than the SMTP 
traffic (which is about 50k or so) and no packet loss.

I only get packet loss if I have Port 25 traffic.

So - what could cause traffing on just port 25 to cause 2 computers to 
have backet loss? Could it be related to the number of connections? It 
does seem like when I turn on the SMTP that it takes a little while 
before the packet loss starts. Say 3 minutes or so.

Thanks in advance.

