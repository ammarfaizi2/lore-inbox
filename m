Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVDLLna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVDLLna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVDLLmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:42:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:60126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262340AbVDLLkQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:40:16 -0400
Date: Tue, 12 Apr 2005 04:39:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050412043952.0644d4ac.akpm@osdl.org>
In-Reply-To: <200504120732.24440.tomlins@cam.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<200504120732.24440.tomlins@cam.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> On Monday 11 April 2005 04:25, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> > 
> > 
> > - The anticipatory I/O scheduler has always been fairly useless with SCSI
> >   disks which perform tagged command queueing.  There's a patch here from Jens
> >   which is designed to fix that up by constraining the number of requests
> >   which we'll leave pending in the device.
> > 
> >   The depth currently defaults to 1.  Tunable in
> >   /sys/block/hdX/queue/iosched/queue_depth
> > 
> >   This patch hasn't been performance tested at all yet.  If you think it is
> >   misbehaving (the usual symptom is processes stuck in D state) then please
> >   report it, then boot with `elevator=cfq' or `elevator=deadline' to work
> >   around it.
> > 
> > - More CPU scheduler work.  I hope someone is testing this stuff.
> 
> Something is not quite right here.  I built rc2-mm3 and booted (uni processor, amd64, preempt on).  
> mm3 lasted about 30 mins before locking up with a dead keyboard.  I had mm2 reboot a few times
> over the last couple of days too.  
> 
> 11-mm3 uptime of 2 weeks+
> 12-rc2-mm2 reboots once every couple of days
> 12-rc2-mm3 locked up within 30 mins using X using kmail/bogofilter

Unpleasant.  Serial console would be nice ;)

> My serial console does not seem to want to work.  Has anything changed with this support?
> 

Don't think so - it works OK here.  Checked the .config?  Does the serial
port work if you do `echo foo > /dev/ttyS0'?  ACPI?

