Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135663AbREBRZE>; Wed, 2 May 2001 13:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135659AbREBRYy>; Wed, 2 May 2001 13:24:54 -0400
Received: from armitage.toyota.com ([63.87.74.3]:59659 "EHLO
	armitage.toyota.com") by vger.kernel.org with ESMTP
	id <S135663AbREBRYc>; Wed, 2 May 2001 13:24:32 -0400
Message-ID: <3AF042C2.2BF4716B@lexus.com>
Date: Wed, 02 May 2001 10:24:18 -0700
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Sim, CT (Chee Tong)" <CheeTong.Sim@sin.rabobank.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [OT] Re: Linux NAT questions- (kernel upgrade??)
In-Reply-To: <1E8992B3CD28D4119D5B00508B08EC5627E8A4@sinxsn02.ap.rabobank.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sim, CT (Chee Tong)" schrieb:

> Hi.. I follow your instruction, but I encounter this issue, my kernel need
> to be upgrade? MAy I know how to determine the current kernel version

uname -a

> and
> how to upgrade it??

Either upgrade to a distro that includes the new kernel
(e.g. latest SuSE or Red Hat) or download kernel source
and compile. It might be helpful to provide the distribution
and version you are using (Red Hat 6.2, Slackware 7,
Debian Potato, etc)

> [root@guava /root]# iptables -t nat -A PREROUTING -p tcp --dst 1.1.1.160 -i
> eth1 -j D
> NAT --to-destination 192.168.200.2
> iptables v1.1.1: can't initialize iptables table `nat': iptables who? (do
> you need to insm
> od?)
> Perhaps iptables or your kernel needs to be upgraded.
>
> [root@guava simc]# rpm -ivh iptables-1_2_0-6_i386.rpm
> error: failed dependencies:
>         kernel >= 2.4.0 is needed by iptables-1.2.0-6

Yes, of course iptables won't work with the old kernel.
If you want to stay with the old kernel, you must use
ipchains instead.

cu

Jup

