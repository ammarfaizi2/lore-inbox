Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281691AbRLNXvH>; Fri, 14 Dec 2001 18:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRLNXu7>; Fri, 14 Dec 2001 18:50:59 -0500
Received: from woody.ichilton.co.uk ([216.28.122.60]:48909 "EHLO
	woody.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S280817AbRLNXur>; Fri, 14 Dec 2001 18:50:47 -0500
Date: Fri, 14 Dec 2001 23:50:40 +0000
From: Ian Chilton <ian@ichilton.co.uk>
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: IP Autoconfig Not Working on Sparc32 (2.4.17-rc1)
Message-ID: <20011214235040.B30047@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Sun Javastation Krups which is happily booting linux-2.4.1
from the network and using nfsroot.

However, trying to get a more recent kernel working.

It's compiling fine and boots, but doesn't seem to do all the bootp /
ip autoconfig stuff - it just complains about no nfs server (which
obviosuly wont work if it doesn't get the ip etc from bootp first).


Server log when trying to boot the 2.4.17-rc1 looks like this:

Dec 14 23:36:01 slinky dhcpd: DHCPDISCOVER from 08:00:20:94:77:a4 via
eth0
Dec 14 23:36:01 slinky dhcpd: DHCPOFFER on 192.168.0.21 to
08:00:20:94:77:a4 via eth0
Dec 14 23:36:01 slinky dhcpd: DHCPREQUEST for 192.168.0.21
(192.168.0.11) from 08:00:20:94:77:a4 via eth0
Dec 14 23:36:01 slinky dhcpd: DHCPACK on 192.168.0.21 to
08:00:20:94:77:a4 via eth0
Dec 14 23:36:02 slinky in.tftpd[4664]: connect from taz.ichilton.local
Dec 14 23:36:02 slinky tftpd[4665]: tftpd: trying to get file:
C0A80015.SUN4M 
Dec 14 23:36:02 slinky tftpd[4665]: tftpd: serving file from
/export/tftpboot 
Dec 14 23:36:03 slinky dhcpd: BOOTREQUEST from 08:00:20:94:77:a4 via
eth0
Dec 14 23:36:03 slinky dhcpd: BOOTREPLY for 192.168.0.21 to taz
(08:00:20:94:77:a4) via eth0
Dec 14 23:36:03 slinky in.tftpd[4672]: connect from taz.ichilton.local
Dec 14 23:36:03 slinky tftpd[4673]: tftpd: trying to get file:
C0A80015.PROL 
Dec 14 23:36:03 slinky tftpd[4673]: tftpd: serving file from
/export/tftpboot 


If I swap back to my trusty 2.4.1, I get this:

Dec 14 23:41:37 slinky dhcpd: DHCPDISCOVER from 08:00:20:94:77:a4 via
eth0
Dec 14 23:41:37 slinky dhcpd: DHCPOFFER on 192.168.0.21 to
08:00:20:94:77:a4 via eth0
Dec 14 23:41:37 slinky dhcpd: DHCPREQUEST for 192.168.0.21
(192.168.0.11) from 08:00:20:94:77:a4 via eth0
Dec 14 23:41:37 slinky dhcpd: DHCPACK on 192.168.0.21 to
08:00:20:94:77:a4 via eth0
Dec 14 23:41:38 slinky in.tftpd[6779]: connect from taz.ichilton.local
Dec 14 23:41:38 slinky tftpd[6780]: tftpd: trying to get file:
C0A80015.SUN4M 
Dec 14 23:41:38 slinky tftpd[6780]: tftpd: serving file from
/export/tftpboot 
Dec 14 23:41:39 slinky dhcpd: BOOTREQUEST from 08:00:20:94:77:a4 via
eth0
Dec 14 23:41:39 slinky dhcpd: BOOTREPLY for 192.168.0.21 to taz
(08:00:20:94:77:a4) via eth0
Dec 14 23:41:39 slinky in.tftpd[6787]: connect from taz.ichilton.local
Dec 14 23:41:39 slinky tftpd[6788]: tftpd: trying to get file:
C0A80015.PROL 
Dec 14 23:41:39 slinky tftpd[6788]: tftpd: serving file from
/export/tftpboot 

[this is where it boots the kernel]

Dec 14 23:41:51 slinky dhcpd: BOOTREQUEST from 08:00:20:94:77:a4 via
eth0
Dec 14 23:41:51 slinky dhcpd: BOOTREPLY for 192.168.0.21 to taz
(08:00:20:94:77:a4) via eth0
Dec 14 23:41:51 slinky rpc.mountd: authenticated mount request from
192.168.0.21:800 for /export/javastation/iclinux (/export/javastation) 


See the extra BOOTP stuff on the end?


I tried passing things like ip=192.168.0.21:192.168.0.11 and ip=bootp
on the command line, but nothing seems to work.


Any ideas?


Thanks!

Ian

