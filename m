Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVA0AWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVA0AWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVA0AW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:22:28 -0500
Received: from [205.233.219.253] ([205.233.219.253]:14545 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S262497AbVAZXIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 18:08:10 -0500
Date: Wed, 26 Jan 2005 18:08:06 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 and disks
Message-ID: <20050126230806.GG18792@conscoop.ottawa.on.ca>
References: <1106250812.3413.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106250812.3413.10.camel@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 12:53:32PM -0700, Trever L. Adams wrote:
> I have a few questions: How stable is firewire (running at 800Mbps or
> faster, if any is available yet)? How stable is the Linux subsystem,
> especially for firewire disks? Is there any particularly 800Mbps bridge
> chips that should be avoided or used?

The sbp2 subsystem has stability problems, but I'm not exactly sure what
they are.  The core also has a few issues, but I don't think they'll
affect you.  This assumes you're running the latest from linux1394.org
svn as there are quite a few unmerged changes (which will hopefully make
it in to 2.6.12).

> How stable is the subsystem when the chain is nearly full (62 devices is
> full right?)

Having lots of devices shouldn't make any difference, one way or the
other.  62 devices is full.  For performance reasons, a tree topology is
preferred to daisy chaining all the devices.

> How many controllers may be in the system before the Firewire subsystem
> gets confused?

Again, it shouldn't matter.  I'm not sure if the SCSI subsystem imposes
a limit on the number of drives.

I suggest asking future 1394 questions on one of the linux1394 lists:
http://sourceforge.net/mail/?group_id=2252  - someone may even have
tried what you're attempting.

Jody

> 
> Trever Adams
> --
> "There are two ways to live your life. One is as though nothing is a
> miracle. The other is as though everything is a miracle." -- Albert
> Einstein
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
