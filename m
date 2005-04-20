Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVDTPB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVDTPB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 11:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVDTPB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 11:01:57 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:6249 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261637AbVDTPBy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 11:01:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nqfljjkIoX589PBRD+D0f4w74EU1tSYs+QtUN1s9Ujc84bA+TUxCQi0Xgavk9pNJhAqkTDg4/Quok8TF0Nyo8d397aKy7f4gYFaIYxW1V1dt2AmtAlGBL8RWY68S2eiUUEzTILMhwETZUZF4N/IHCRlyS8nBO1W5cEah2HnP+V8=
Message-ID: <363f92a8050420080112dec5db@mail.gmail.com>
Date: Wed, 20 Apr 2005 08:01:53 -0700
From: Dheeraj Pandey <dheeraj@gmail.com>
Reply-To: Dheeraj Pandey <dheeraj@gmail.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: writev to scsi disks
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if I did a simple writev to a SCSI disk, does it take
the sg path to the device? I am guessing sg (REQ_SPECIAL) is only
true for character devices (and ioctl's) and not block devices.

These are my questions:
  - Is sg a common feature among SCSI disks these days? How do I know
what disks support this feature (any capabilities published by the driver)?
  - How does one make writev work for SCSI disk (as a block device)
in direct_io?
  - If I use SCSI disks as character device, can I simply use writev on the
character device file, and will sg codepath be taken?
