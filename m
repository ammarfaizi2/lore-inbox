Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVKLGDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVKLGDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 01:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVKLGDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 01:03:41 -0500
Received: from mail.dvmed.net ([216.237.124.58]:48014 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932158AbVKLGDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 01:03:40 -0500
Message-ID: <437585B9.5090004@pobox.com>
Date: Sat, 12 Nov 2005 01:03:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [2.6.15-rc1] VFS: file-max limit 400490 reached
References: <43757D18.9090109@pobox.com>
In-Reply-To: <43757D18.9090109@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------050008070308060006010500"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050008070308060006010500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> 
> I rebooted my RHEL4-based ipv4/ipv6 gateway/server into 2.6.15-rc1, and 
> very soon the box was brought to its knees, spewing
> 
>     VFS: file-max limit 400490 reached

Follow-up:  I may have excised too much from the head of the log I posted.

It now looks like the radvd troubles may have started with a link 
up/down event.

Attached is some additional lines found at the -head- of the previously 
posted log.


--------------050008070308060006010500
Content-Type: text/plain;
 name="log2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log2.txt"

Nov 11 22:38:32 pretzel dhcpd: dhcpd startup succeeded
Nov 11 22:38:33 pretzel exim: exim startup succeeded
Nov 11 22:38:34 pretzel httpd: httpd startup succeeded
Nov 11 22:38:34 pretzel crond: crond startup succeeded
Nov 11 22:38:34 pretzel anacron: anacron startup succeeded
Nov 11 22:38:35 pretzel atd: atd startup succeeded
Nov 11 22:38:40 pretzel login(pam_unix)[4705]: session opened for user root by LOGIN(uid=0)
Nov 11 22:38:40 pretzel  -- root[4705]: ROOT LOGIN ON tty1
Nov 11 22:38:55 pretzel login(pam_unix)[4705]: session closed for user root
Nov 11 22:45:54 pretzel sshd(pam_unix)[5241]: session opened for user jgarzik by (uid=0)
Nov 11 22:45:58 pretzel sshd(pam_unix)[5283]: session opened for user jgarzik by (uid=0)
Nov 11 23:01:01 pretzel crond(pam_unix)[28125]: session opened for user root by (uid=0)
Nov 11 23:01:02 pretzel crond(pam_unix)[28125]: session closed for user root
Nov 11 23:01:39 pretzel sshd(pam_unix)[29561]: session opened for user jgarzik by (uid=0)
Nov 11 23:01:48 pretzel sshd(pam_unix)[29561]: session closed for user jgarzik
Nov 11 23:34:00 pretzel kernel: e1000: eth1: e1000_watchdog_task: NIC Link is Down
Nov 11 23:34:01 pretzel netplugd[4112]: eth1: state ACTIVE flags 0x00001043 UP,BROADCAST,RUNNING,MULTICAST -> 0x00001003 UP,BROADCAST,MULTICAST
Nov 11 23:34:01 pretzel netplugd[25700]: /etc/netplug.d/netplug eth1 out -> pid 25700
Nov 11 23:34:01 pretzel radvd[4428]: resetting ipv6-allrouters membership on eth1
Nov 11 23:34:01 pretzel radvd[4428]: can't join ipv6-allrouters on eth1
Nov 11 23:34:07 pretzel kernel: e1000: eth1: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
Nov 11 23:34:07 pretzel netplugd[4112]: eth1: state OUTING flags 0x00001003 UP,BROADCAST,MULTICAST -> 0x00001043 UP,BROADCAST,RUNNING,MULTICAST
Nov 11 23:34:10 pretzel radvd[4428]: resetting ipv6-allrouters membership on eth1
Nov 11 23:34:10 pretzel radvd[4428]: can't join ipv6-allrouters on eth1
Nov 11 23:34:16 pretzel radvd[4428]: resetting ipv6-allrouters membership on eth1
Nov 11 23:34:16 pretzel radvd[4428]: can't join ipv6-allrouters on eth1
Nov 11 23:34:23 pretzel radvd[4428]: resetting ipv6-allrouters membership on eth1
Nov 11 23:34:23 pretzel radvd[4428]: can't join ipv6-allrouters on eth1
Nov 11 23:34:31 pretzel radvd[4428]: resetting ipv6-allrouters membership on eth1
Nov 11 23:34:31 pretzel radvd[4428]: can't join ipv6-allrouters on eth1
Nov 11 23:34:37 pretzel radvd[4428]: resetting ipv6-allrouters membership on eth1
[...]

--------------050008070308060006010500--
