Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTLXRtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbTLXRtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:49:53 -0500
Received: from mail.aei.ca ([206.123.6.14]:59112 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S263771AbTLXRtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:49:51 -0500
Subject: Re: 2.6 unknown partition table
From: Shane Shrybman <shrybman@aei.ca>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1072284569.4710.3.camel@leto.cs.pocnet.net>
References: <1072277542.10203.14.camel@mars.goatskin.org>
	 <1072284569.4710.3.camel@leto.cs.pocnet.net>
Content-Type: text/plain
Organization: 
Message-Id: <1072288180.10203.18.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Dec 2003 12:49:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-24 at 11:49, Christophe Saout wrote:
> Am Mi, den 24.12.2003 schrieb Shane Shrybman um 15:52:
> 
> > I noticed this in the logs yesterday on 2.6.0-test11-mm1 and upgraded to
> > 2.6.0-mm1, but its still there. I use LVM on that disk and it is working
> > fine, (LV file systems are mountable and useable).
> >
> > Advice?
> > 
> > # fdisk -l /dev/hdg
> > [...]
> > Disk /dev/hdg doesn't contain a valid partition table
> >
> > [...]
> > vgdisplay  PV Name               /dev/hdg     
> 
> Everything is fine. You put your physical volume directly on the
> harddisk, not in a partition, so you don't have a partition table.
> vgscan recognizes the hard disk itself as LVM physical volume anyway
> that's why it works.
> 

Eeek.. I knew that! ;) Sorry for the stupid question and Happy Holidays!

> If you want to get rid of this, the next time you create a PV please
> create a partition first with fdisk, e.g. /dev/hdg1 with type 8e (LVM)
> and then pvcreate /dev/hdg1.
> 
> --
> Christophe Saout <christophe@saout.de>
> Please avoid sending me Word or PowerPoint attachments.
> See http://www.fsf.org/philosophy/no-word-attachments.html
> 

