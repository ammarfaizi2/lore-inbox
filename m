Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130260AbRCCD07>; Fri, 2 Mar 2001 22:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130257AbRCCD0t>; Fri, 2 Mar 2001 22:26:49 -0500
Received: from mercury.ST.HMC.Edu ([134.173.57.219]:17161 "HELO
	mercury.st.hmc.edu") by vger.kernel.org with SMTP
	id <S130253AbRCCD0n>; Fri, 2 Mar 2001 22:26:43 -0500
From: Nate Eldredge <neldredge@hmc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15008.25709.185798.826060@mercury.st.hmc.edu>
Date: Fri, 2 Mar 2001 19:26:37 -0800
To: linux-kernel@vger.kernel.org
Subject: Oddity with /proc/sys/net/ipv4/conf/all
X-Mailer: VM 6.76 under Emacs 20.5.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/networking/ip-sysctl.txt:

conf/all/* is special and changes the settings for all interfaces.

However, I did this:

mercury:~# echo 1 >/proc/sys/net/ipv4/conf/all/log_martians 
mercury:~# cat /proc/sys/net/ipv4/conf/all/log_martians 
1
mercury:~# cat /proc/sys/net/ipv4/conf/lo/log_martians 
0
mercury:~# cat /proc/sys/net/ipv4/conf/eth0/log_martians 
0

So it looks like the changes are not reflected in the individual
interfaces.  What's going on?

Also, can anyone tell me how to test whether these options are
working?  (For instance, how can I send myself a martian packet, to
see if it is logged?)  I considered the possibility that the option
really is on, and sysctl just doesn't report it, but I didn't know how
to find out.

This is kernel 2.4.2-ac7.

-- 

Nate Eldredge
neldredge@hmc.edu
