Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTJ2RWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 12:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbTJ2RWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 12:22:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:33987 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261193AbTJ2RWX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 12:22:23 -0500
Content-Type: text/plain;
  charset="utf-8"
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
Date: Wed, 29 Oct 2003 09:20:06 -0800
User-Agent: KMail/1.4.1
References: <3F9D82F0.4000307@mvista.com> <20031028224416.GA8671@kroah.com> <pan.2003.10.29.14.30.29.628488@dungeon.inka.de>
In-Reply-To: <pan.2003.10.29.14.30.29.628488@dungeon.inka.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200310290920.06056.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 October 2003 06:30 am, Andreas Jellinghaus wrote:
> On Tue, 28 Oct 2003 22:52:33 +0000, Greg KH wrote:
[snip]
> > that udev is suffering from "lack of maintainability and bloat" if you
> > really want :)
>
> bloat. lots of bloat. what is that tdb database for?
> filesystems are persistent. if you want to save space,
> create a tar file :-)

[snip]


The tdb database is for storing current device information, udev needs to 
reference names to devices. The database also enables an api for applications 
to query what devices are on the system, their names, and their nodes. 

Using tdb has its advantages too; it's small, it's flexible, it's fast, it can 
be in memory or on disk, and it has locking for multiple accesses.

IMVHO - tdb isn't bloat.

Thanks,

Dan
