Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423682AbWLBLgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423682AbWLBLgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423685AbWLBLgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:36:13 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:21773 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1423682AbWLBLgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:36:12 -0500
Date: Sat, 2 Dec 2006 12:36:18 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon/abituguru: handle sysfs errors
Message-Id: <20061202123618.67047029.khali@linux-fr.org>
In-Reply-To: <452B6569.7050404@hhs.nl>
References: <20061010065359.GA21576@havoc.gtf.org>
	<452B4B59.1050606@hhs.nl>
	<20061010110803.1a70b576.khali@linux-fr.org>
	<452B6569.7050404@hhs.nl>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

On Tue, 10 Oct 2006 11:18:33 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > The patch isn't wrong per se, but it could be made more simple, and is
> > incomplete in comparison to what was done for all other hardware
> > monitoring drivers:
> > 
> > * We want to create all the files before registering with the hwmon
> >   class, this closes a race condition.
> > * We want to delete all the device files at regular cleanup time (after
> >   unregistering with the hwmon class).
> > * It's OK to call device_remove_file() on a non-existent file, so the
> >   error path can be simplified.
> >
> > I'd like the abituguru driver to behave the same as all other hardware
> > monitoring drivers to lower the maintenance effort. Can either you
> > or Jeff work up a compliant patch? 
> 
> I understand Jeff any chance you can do a new revision of
> your patch? Otherwise I'll take care of it as time permits.

I'm still waiting for this patch. It'd be nice to have the abituguru
driver fixed in 2.6.20.

Thanks,
-- 
Jean Delvare
