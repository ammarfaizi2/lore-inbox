Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVCKLgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVCKLgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 06:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVCKLgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 06:36:50 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:14341 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262678AbVCKLgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 06:36:48 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Simone Piunno <simone.piunno@wseurope.com>, linux-kernel@vger.kernel.org,
       Fabio Coatti <fabio.coatti@wseurope.com>
Subject: Re: bonnie++ uninterruptible under heavy I/O load
Date: Fri, 11 Mar 2005 13:35:56 +0200
User-Agent: KMail/1.5.4
References: <200503111208.20283.simone.piunno@wseurope.com>
In-Reply-To: <200503111208.20283.simone.piunno@wseurope.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503111335.56782.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 13:08, Simone Piunno wrote:
> 
> Hello,
> 
> I'm testing a pair of new servers we just bought.
> They are HP DL585 dual Opteron 844 with 8G RAM, RAID1 over 2x72G SCSI disks 
> (HP CISS driver) and running 2.6.11.  In /proc/driver/cciss/cciss0 we have:
> 
> cciss0: HP Smart Array 5i Controller
> Board ID: 0x40800e11
> Firmware Version: 2.56
> IRQ: 18
> Logical drives: 1
> Current Q depth: 0
> Current # commands on controller: 0
> Max Q depth since init: 6
> Max # commands on controller since init: 190
> Max SG entries since init: 31
> cciss/c0d0:       72.83GB       RAID 1(1+0)
> 
> As a test, I'm running bonnie++ while two md5sum are checksumming /dev/zero.
> I see 98% CPU is correctly allocated on the two md5sum processes, but when 
> bonnie is in the "Writing intelligently phase" the system appears noticeably 
> unresponsive (high latency) and bonnie and pdflush are uninterruptible almost 
> all the time (D in top output).  If I try to kill -9 bonnie++, it goes on 
> consuming I/O bandwith for several tens of seconds, before finally dieing.
> 
> Unresponsiveness is not 2.6.11 specific (we've seen the same thing on 2.6.10 
> and 2.6.8), not I/O scheduler specific ("as" and "deadline" behave the same)
> and not CPU/SMP specific (reproduced on single P4 HT and single P3), but only 
> on these two DL585 servers we've seen bonnie++ resisting kill -9 for tens of 
> seconds.
> 
> Of course on request I can provide any other useful info.
> Any help is appreciated.

I think Alt-SysRq-T will be interesting to see
--
vda

