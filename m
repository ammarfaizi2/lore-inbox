Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268640AbRGZS2L>; Thu, 26 Jul 2001 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268634AbRGZS2C>; Thu, 26 Jul 2001 14:28:02 -0400
Received: from smtp.monmouth.com ([209.191.58.6]:63756 "EHLO smtp.monmouth.com")
	by vger.kernel.org with ESMTP id <S268635AbRGZS1y>;
	Thu, 26 Jul 2001 14:27:54 -0400
Message-ID: <3B60532C.CEE62B4D@monmouth.com>
Date: Thu, 26 Jul 2001 13:28:12 -0400
From: Dipak Biswas <dipak@monmouth.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-6.1smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fwd: Facing problem
In-Reply-To: <20010725030855.696.qmail@pc7.prs.nunet.net> <3B604125.D11E95F8@monmouth.com>
Content-Type: multipart/mixed;
 boundary="------------9752F210DB92E3BEC305A13C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------9752F210DB92E3BEC305A13C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all,
    I'm facing problem to bring up 2.4.5 kernel properly. The eth0 is not
coming up and lockd is failing because of lockdsvc function not found.
    I've attached part of /var/log/boot.log file for your info. The problematic
parts are identified with "^^^^^^^^" and my queries are marked with
">>>>>>>>>".
    Please suggest.

Thanks in advance,
Dipak




--------------9752F210DB92E3BEC305A13C
Content-Type: text/plain; charset=us-ascii;
 name="bootlog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootlog.txt"

Jul 26 09:57:56 mozart syslog: syslogd startup succeeded
Jul 26 09:57:56 mozart syslog: klogd startup succeeded
Jul 26 09:57:56 mozart identd: identd startup succeeded
Jul 26 09:57:57 mozart atd: atd startup succeeded
Jul 26 09:57:57 mozart crond: crond startup succeeded
Jul 26 09:57:57 mozart rc: Starting pcmcia succeeded
Jul 26 09:57:45 mozart rc.sysinit: Mounting proc filesystem succeeded 
Jul 26 09:57:45 mozart sysctl: net.ipv4.ip_forward = 0 
Jul 26 09:57:45 mozart sysctl: net.ipv4.conf.all.rp_filter = 1 
Jul 26 09:57:45 mozart sysctl: kernel.sysrq = 0 
Jul 26 09:57:45 mozart sysctl: error: 'net.ipv4.ip_always_defrag' is an unknown key 
                                       ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>	There is no IP Masquerading code existing in the 2.4.5 kernel
	release.

Jul 26 09:57:45 mozart rc.sysinit: Configuring kernel parameters succeeded 
Jul 26 09:57:45 mozart date: Thu Jul 26 09:57:45 EDT 2001 
Jul 26 09:57:45 mozart rc.sysinit: Setting clock : Thu Jul 26 09:57:45 EDT 2001 succeeded 
Jul 26 09:57:45 mozart rc.sysinit: Activating swap partitions succeeded 
Jul 26 09:57:45 mozart rc.sysinit: Setting hostname mozart succeeded 
Jul 26 09:57:45 mozart fsck: /dev/hda8: clean, 38953/218176 files, 291624/435755 blocks 
Jul 26 09:57:45 mozart rc.sysinit: Checking root filesystem succeeded 
Jul 26 09:57:45 mozart rc.sysinit: Remounting root filesystem in read-write mode succeeded 
Jul 26 09:57:45 mozart rc.sysinit: Finding module dependencies succeeded 
Jul 26 09:57:45 mozart aumix-minimal: aumix:  error opening mixer 
                                      ^^^^^^
>>>>>>>>>>>>	What could be the problem. Sound configuration not well??

Jul 26 09:57:45 mozart rc.sysinit: Loading mixer settings failed 
Jul 26 09:57:45 mozart fsck: /dev/hda1: clean, 31/6024 files, 9908/24066 blocks 
Jul 26 09:57:45 mozart fsck: /dev/hda6: clean, 2123/641280 files, 264924/1281175 blocks 
Jul 26 09:57:45 mozart fsck: /dev/hda7: clean, 319/256512 files, 8082/512064 blocks 
Jul 26 09:57:45 mozart fsck: /dev/hda5: clean, 144942/1310720 files, 876420/2616579 blocks 
Jul 26 09:57:45 mozart rc.sysinit: Checking filesystems succeeded 
Jul 26 09:57:45 mozart rc.sysinit: Mounting local filesystems succeeded 
Jul 26 09:57:45 mozart rc.sysinit: Turning on user and group quotas for local filesystems succeeded 
Jul 26 09:57:58 mozart inet: inetd startup succeeded
Jul 26 09:57:46 mozart rc.sysinit: Enabling swap space succeeded 
Jul 26 09:57:55 mozart kudzu:  succeeded 
Jul 26 09:57:55 mozart sysctl: net.ipv4.ip_forward = 0 
Jul 26 09:57:55 mozart sysctl: net.ipv4.conf.all.rp_filter = 1 
Jul 26 09:57:55 mozart sysctl: kernel.sysrq = 0 
Jul 26 09:57:55 mozart sysctl: error: 'net.ipv4.ip_always_defrag' is an unknown
key 
>>>>>>>>>>>>>                          ^^^^^^^^^^^^^^^^^^^^^^^^^


Jul 26 09:57:55 mozart network: Setting network parameters succeeded 
Jul 26 09:57:55 mozart network: Bringing up interface lo succeeded 
Jul 26 09:57:55 mozart ifup: Delaying eth0 initialization. 
Jul 26 09:57:55 mozart network: Bringing up interface eth0 failed 
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>	I think because of previous sysctl error, eth0 init failed and
	network connection couldn't come up.

Jul 26 09:57:55 mozart portmap: portmap startup succeeded 
Jul 26 09:57:55 mozart rpc.lockd: lockdsvc: Function not implemented 
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Jul 26 09:57:55 mozart nfslock: rpc.lockd startup failed 
                                ^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>>>>>>>	I have compiled LOCKD as module. Should I make it built-in??

Jul 26 09:57:56 mozart nfslock: rpc.statd startup succeeded 
Jul 26 09:57:56 mozart apmd: apmd startup succeeded 
Jul 26 09:57:56 mozart random: Initializing random number generator succeeded 
Jul 26 09:57:58 mozart lpd: lpd startup succeeded
Jul 26 09:57:56 mozart mount: mount: RPC: Unable to send; errno = Network is unreachable 
Jul 26 09:57:56 mozart mount: mount: RPC: Unable to send; errno = Network is unreachable 
Jul 26 09:57:58 mozart keytable: Loading keymap: 
Jul 26 09:57:56 mozart netfs: Mounting NFS filesystems failed 
Jul 26 09:57:56 mozart netfs: Mounting other filesystems succeeded 
Jul 26 09:57:58 mozart keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Jul 26 09:57:58 mozart keytable: Loading system font: 
Jul 26 09:57:58 mozart rc: Starting keytable succeeded
Jul 26 09:57:58 mozart gpm: gpm startup succeeded
Jul 26 09:57:59 mozart httpd: [Thu Jul 26 09:57:59 2001] [alert] httpd: Could not determine the server's fully qualified domain name, using 127.0.0.1 for ServerName
Jul 26 09:57:59 mozart httpd: 
Jul 26 09:57:59 mozart httpd: httpd startup succeeded
Jul 26 09:58:23 mozart tomcat: Using classpath: /var/tomcat/lib/ant.jar:/var/tomcat/lib/jasper.jar:/var/tomcat/lib/jaxp.jar:/var/tomcat/lib/parser.jar:/var/tomcat/lib/servlet.jar:/var/tomcat/lib/test:/var/tomcat/lib/webserver.jar:/usr/java/jdk1.3.0_02/lib/tools.jar
Jul 26 09:58:23 mozart tomcat: tomcat startup succeeded
Jul 26 09:58:25 mozart xfs: xfs startup succeeded
Jul 26 09:58:26 mozart linuxconf: Linuxconf final setup
Jul 26 09:58:28 mozart rc: Starting linuxconf succeeded


--------------9752F210DB92E3BEC305A13C--

