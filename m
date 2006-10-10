Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWJJJen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWJJJen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWJJJem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:34:42 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:57611 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S965134AbWJJJem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:34:42 -0400
Date: Tue, 10 Oct 2006 11:34:41 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon/abituguru: handle sysfs errors
Message-Id: <20061010113441.24b19b99.khali@linux-fr.org>
In-Reply-To: <452B6569.7050404@hhs.nl>
References: <20061010065359.GA21576@havoc.gtf.org>
	<452B4B59.1050606@hhs.nl>
	<20061010110803.1a70b576.khali@linux-fr.org>
	<452B6569.7050404@hhs.nl>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

> > * We want to delete all the device files at regular cleanup time (after
> >   unregistering with the hwmon class).
> 
> Is this really nescesarry? AFAIK the files get deleted when the device
> gets deleted.

The point is that the device shouldn't be deleted if we were following
the device driver model. After all the uGuru device exists in your
system before the abituguru driver is loaded, and is still there after
the driver is unloaded.

Now I agree that for now it won't make a difference, be we are
preparing for the future, and all other hardware monitoring drivers
were updated that way already.

> > * It's OK to call device_create_file() on a non-existent file, so the
> >   error path can be simplified.
> 
> ?? You mean device_remove_file I assume?

Oops, yes, that was a typo, sorry.

Thanks,
-- 
Jean Delvare
