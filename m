Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUBZUCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbUBZUCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:02:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:14512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262837AbUBZUCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:02:38 -0500
Date: Thu, 26 Feb 2004 12:03:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org, gluk@php4.ru, anton@megashop.ru,
       mfedyk@matchmail.com
Subject: Re: 2.6.1 IO lockup on SMP systems
Message-Id: <20040226120310.037a6702.akpm@osdl.org>
In-Reply-To: <200402261730.51874.rathamahata@php4.ru>
References: <200401311940.28078.rathamahata@php4.ru>
	<200402261519.35506.rathamahata@php4.ru>
	<20040226045331.060c07d3.akpm@osdl.org>
	<200402261730.51874.rathamahata@php4.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
>
> > So.  What are you using which is different from everyone else?  DAC960 I
>  > see.  What about firewall setups, NIC drivers, RAID/MD/etc?  Anything in
>  > there which isn't a mainstream thing?
> 
>  Iptables (ipt_REJECT,ipt_state,ip_conntrack,ipt_state,iptable_filter modules)
>  is used as firewall.
> 
>  I think NICs are pretty usual:
>  00:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
>  00:05.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
>  handled by Intel e100 driver.
> 
>  Only plain partitions (there is no md, dm or something like this):
>  [rathamahata@ope rathamahata]$ mount
>  /dev/rd/host0/target0/part1 on / type reiserfs (rw)
>  none on /proc type proc (rw)
>  none on /dev/pts type devpts (rw,gid=5,mode=620)
>  /dev/rd/host0/target1/part2 on /usr/local type reiserfs (rw)
>  /dev/rd/host0/target3/part1 on /var type reiserfs (rw,noatime,nodiratime)
>  /dev/rd/host0/target7/part1 on /var/www/html/fo type reiserfs (rw,noatime,nodiratime)
>  /dev/rd/host0/target2/part1 on /home type reiserfs (rw,noatime,nodiratime)
>  /dev/rd/host0/target4/part1 on /var/lib/innodb/1 type reiserfs (rw,noatime,nodiratime,notail)
>  /dev/rd/host0/target5/part1 on /var/lib/innodb/2 type reiserfs (rw,noatime,nodiratime,notail)
>  /dev/rd/host0/target6/part1 on /var/lib/oracle/db04 type reiserfs (rw,noatime,nodiratime,notail)
>  sysfs on /sys type sysfs (rw)

OK, thanks.  Is there any possibility that you can run without iptables for
a while, see if that fixes it?

