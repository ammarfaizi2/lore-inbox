Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVDNATQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDNATQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVDNAQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:16:59 -0400
Received: from mail.aei.ca ([206.123.6.14]:24818 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261248AbVDNAQE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:16:04 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm3
Date: Wed, 13 Apr 2005 20:15:49 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050411012532.58593bc1.akpm@osdl.org> <200504120732.24440.tomlins@cam.org> <20050412043952.0644d4ac.akpm@osdl.org>
In-Reply-To: <20050412043952.0644d4ac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504132015.49877.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 April 2005 07:39, Andrew Morton wrote:
> Ed Tomlinson <tomlins@cam.org> wrote:
> >
> > On Monday 11 April 2005 04:25, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> > > 
> > > 
> > > - The anticipatory I/O scheduler has always been fairly useless with SCSI
> > >   disks which perform tagged command queueing.  There's a patch here from Jens
> > >   which is designed to fix that up by constraining the number of requests
> > >   which we'll leave pending in the device.
> > > 
> > >   The depth currently defaults to 1.  Tunable in
> > >   /sys/block/hdX/queue/iosched/queue_depth
> > > 
> > >   This patch hasn't been performance tested at all yet.  If you think it is
> > >   misbehaving (the usual symptom is processes stuck in D state) then please
> > >   report it, then boot with `elevator=cfq' or `elevator=deadline' to work
> > >   around it.
> > > 
> > > - More CPU scheduler work.  I hope someone is testing this stuff.
> > 
> > Something is not quite right here.  I built rc2-mm3 and booted (uni processor, amd64, preempt on).  
> > mm3 lasted about 30 mins before locking up with a dead keyboard.  I had mm2 reboot a few times
> > over the last couple of days too.  
> > 
> > 11-mm3 uptime of 2 weeks+
> > 12-rc2-mm2 reboots once every couple of days
> > 12-rc2-mm3 locked up within 30 mins using X using kmail/bogofilter
> 
> Unpleasant.  Serial console would be nice ;)
> 
> > My serial console does not seem to want to work.  Has anything changed with this support?
> > 
> 
> Don't think so - it works OK here.  Checked the .config?  Does the serial
> port work if you do `echo foo > /dev/ttyS0'?  ACPI?

Turned out it was some old ups software that got reactivated on the box displaying the
console - was a pain to disable it....

In any case, when the box reboots there are not any messages.  Any ideas on what debug
options to enable or suggestions on how we can figure out the cause of the reboots.

TIA,
Ed Tomlinson
