Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbTFEWqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265244AbTFEWqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:46:52 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:3365 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265239AbTFEWqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:46:51 -0400
Date: Thu, 5 Jun 2003 15:56:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@suse.cz>
Cc: mochel@osdl.org, greg@kroah.com, hannal@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
Message-Id: <20030605155642.68179245.akpm@digeo.com>
In-Reply-To: <20030605224535.GH608@elf.ucw.cz>
References: <20030605220716.GF608@elf.ucw.cz>
	<Pine.LNX.4.44.0306051511350.13077-100000@cherise>
	<20030605224535.GH608@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2003 23:00:23.0694 (UTC) FILETIME=[3EF742E0:01C32BB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> > > Okay, that means that another patch is needed to create hierarchy for
> > > power managment... This sysfs stuff is getting hairy.
> > 
> > No it's not. The hierarchy is the device tree, which is the original 
> > purpose of it, remember? 
> 
> device tree is okay with me, but... it took quite a long patch to add
> it to classes. I thought that classes are only going to be symlinks
> into device tree, but this patch added classes without adding to the
> device tree...

Al Viro has asked that sysfs conversions such as this be placed on hold
until we sort through the newly-added bugs arising from the sysfsification
of netdevs and request queues.  

So yeah, do the work, but please make sure that you understand what went
wrong with netdevs and queues, and make sure that the input sysfsification
addresses those problems.  Preferably in the same way...

