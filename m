Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbUBDWmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUBDWmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:42:06 -0500
Received: from mail.logiccontrol.es ([195.76.168.52]:12474 "EHLO
	mail.logiccontrol.es") by vger.kernel.org with ESMTP
	id S264356AbUBDWmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:42:00 -0500
From: Pedro Larroy <piotr@member.fsf.org>
Reply-To: piotr@member.fsf.org
Organization: larroy.com
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andreas Steinmetz <ast@domdv.de>
Subject: Re: Promise PDC20269 (Ultra133 TX2) + Software RAID
Date: Wed, 4 Feb 2004 23:41:44 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <6FF5C83C-55FA-11D8-AC00-000A95CEEE4E@computeraddictions.com.au> <4021628D.5030805@domdv.de> <200402042306.54046.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402042306.54046.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402042341.45215.piotr@member.fsf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 February 2004 23:06, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 04 of February 2004 22:22, Andreas Steinmetz wrote:
> > Pedro Larroy wrote:
> > > On Tue, Feb 03, 2004 at 02:08:31PM +1030, Ryan Verner wrote:
> > >>And the machine is randomly locking up, and of course, on reboot, the
> > >>raid array is rebuilt.  Ouch.  Any clues as to why?  I'm sure the hard
> > >>drive hasn't failed as it's brand new; I suspect a chipset
> > >>compatibility problem or something.
> > >>
> > >>R
> > >
> > > I have similar issues with 20269. I have two cards on one box doing sw
> > > raid5 on 6 ide drives. It only runs stably with 2.4.19
> > > It has been many months since I assembled that box, and I've tried
> > > kernels from 2.4.20-ac, 2.5.x, 2.6.2  and all hang after some time
> > > running.
> > >
> > > I remember that pdcs also hanged a dual processor box.
> >
> > In my case (see my mail to lkml today) I do suspect concurrent disk
> > access and IO-APIC to be the culprit. If you're using an IO-APIC try
> > booting with either "noapic" or "hdx=serialize" where hdx is one of the
> > disks of your controller card.
>
> Try "noapic" first, "hdx=serialize" will kill you RAID performance.
>
> ---bart

That box doesn't have APIC. just XT-PIC   :(

-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     

