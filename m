Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWDLKea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWDLKea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 06:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWDLKea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 06:34:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37007 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932145AbWDLKea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 06:34:30 -0400
Date: Wed, 12 Apr 2006 03:34:13 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Binary sysfs blobs
Message-Id: <20060412033413.6fa5dd54.zaitcev@redhat.com>
In-Reply-To: <20060411204203.GA6177@kroah.com>
References: <20060411110841.71390306.zaitcev@redhat.com>
	<20060411204203.GA6177@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.15; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2006 13:42:03 -0700, Greg KH <greg@kroah.com> wrote:

> No.  Binary sysfs files are for "pass-through" mode only.  You are ONLY
> allowed to use them if you want to read from, or write to, some bit of
> hardware and not manipulate the data at all.  Examples of this is the
> raw PCI config space, firmware binary blobs and BIOS upgrades.

I see. Kind of the opposite of what I thought they were, but it
makes sense. Thanks.

> You should NEVER pass a raw structure through sysfs by using a binary
> file.  If anyone sees anywhere in the current kernel that does this,
> please let me know and I'll go hit them with a big stick...

I dunno how raw this is, but chp_measurement_copy_block and
chp_measurement_read (in drivers/s390/cio/chsc.c) sure look like
passing structures, in 2.6.17-rc1. However, the code does not interpret
the structures, so maybe it's raw enough.

-- Pete
