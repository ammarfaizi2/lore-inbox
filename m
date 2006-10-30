Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161346AbWJ3Ut7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbWJ3Ut7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbWJ3Ut7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:49:59 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:4507 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161346AbWJ3Ut6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:49:58 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.19-rc3-mm1 - udev doesn't work (was: ATI SATA controller not detected)
Date: Mon, 30 Oct 2006 21:48:33 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <200610302115.37688.rjw@sisk.pl> <20061030202251.GA1235@kroah.com>
In-Reply-To: <20061030202251.GA1235@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610302148.34218.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 30 October 2006 21:22, Greg KH wrote:
> On Mon, Oct 30, 2006 at 09:15:37PM +0100, Rafael J. Wysocki wrote:
> > Sorry, I was wrong.
> > 
> > The controller _is_ detected and handled properly, but udev is apparently
> > unable to create the special device files for SATA drives/partitions even
> > though CONFIG_SYSFS_DEPRECATED is set.
> 
> This config option should not affect the block device sysfs files at all
> at this point in time.
> 
> What does 'tree /sys/block/' show?

I can't run 'tree', but 'ls' works somehow (can't mount the root fs).  The
block device sysfs files seem to be present

> If the files show up there properly, udev should handle them just fine.

It doesn't.

Well, I can binary search for the offending patch if that helps.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
