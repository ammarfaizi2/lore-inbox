Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbTFEWUS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTFEWUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:20:18 -0400
Received: from pc-80-192-208-23-mo.blueyonder.co.uk ([80.192.208.23]:64993
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S265162AbTFEWUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:20:16 -0400
Subject: Re: 2.5.70 latest: breaks gnome
From: Edward Tandi <ed@efix.biz>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
In-Reply-To: <3EDFBD08.5060902@tmsusa.com>
References: <20030604142241.0dc6f34e.shemminger@osdl.org>
	 <3EDE7398.70005@tmsusa.com>	<20030605111212.33e63d46.shemminger@osdl.org>
	 <3EDFB3E2.2090308@tmsusa.com> <20030605143346.197a8923.akpm@digeo.com>
	 <3EDFBD08.5060902@tmsusa.com>
Content-Type: text/plain
Message-Id: <1054852458.1886.18.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 05 Jun 2003 23:34:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI,

I have just tried mm5. I have Gnome2 working (using kdm) but am still
having the same problems as mm3:

1) gnome-terminal still only works as root.

2) xosview still freezes (reading /proc/*)

3) rmmod still not working -"Can't open 'analog': No such file or
directory"

4) su - <user> returns "operation not permitted". Works as root though
and thereafter as <user>.

5) This is the second time this has happened after switching to 2.5.x;
My Evolution groups (left-hand icon bar) have gone missing.

6) from /var/log/messages: /sbin/mingetty[2583]: /dev/tty4: cannot open
tty: Inappropriate ioctl for device

7) Excessive "anticipatory scheduling elevator" messages allover in
/var/log/messages.

8) from dmesg: process `named' is using obsolete setsockopt SO_BSDCOMPAT

I think there is something "not quite right" in the terminal I/O area.

Ed-T.


On Thu, 2003-06-05 at 22:58, jjs wrote:
> Hello, this may be of interest:
> 
> 2.5.70-mm3: gdm is fine
> 2.5.70-mm4: gdm broken, won't start
> 2.5.70-mm5: gdm still broken, won't start, despite reports of a fix
> 
> Hardware:
> -------------
> celeron 1.2 G on genuine intel motherboard
> 2X e100 ethernet
> 40 GB IDE
> 512 MB RAM
> 
> Distro:
> -----------
> Red Hat 9 w/ all updates
> 
> config attached
> 
> 
> There is no associated kernel oops, only
> an error message from gdm -
> 
> Here is the relevant snippet from syslog:
> 
> Jun  5 12:47:47 jyro portsentry: Starting portsentry -audp:  succeeded
> Jun  5 12:47:48 jyro kernel: ip_tables: (C) 2000-2002 Netfilter core team
> Jun  5 12:47:48 jyro kernel: ip_conntrack version 2.1 (4086 buckets, 
> 32688 max)
> - 324 bytes per conntrack
> Jun  5 12:47:52 jyro gdm[1288]: gdm_slave_xioerror_handler: Fatal X 
> error - Rest
> arting :0
> Jun  5 12:47:54 jyro gdm[1295]: gdm_slave_xioerror_handler: Fatal X 
> error - Rest
> arting :0
> Jun  5 12:47:58 jyro gdm[1301]: gdm_slave_xioerror_handler: Fatal X 
> error - Rest
> arting :0
> Jun  5 12:48:02 jyro gdm[1309]: gdm_slave_xioerror_handler: Fatal X 
> error - Rest
> arting :0
> Jun  5 12:48:02 jyro gdm[1242]: deal_with_x_crashes: Running the 
> XKeepsCrashing
> script
> 

