Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTJFQAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTJFQAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:00:55 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:50841 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262101AbTJFQAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:00:54 -0400
Subject: Re: [PATCH] s390 (2/7): common i/o layer.
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, viro@www.linux.org.uk
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFA892CF2E.C36F5F22-ONC1256DB7.00570E6C-C1256DB7.0057D283@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 6 Oct 2003 17:59:15 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/10/2003 17:59:47
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's a trivial deadlock.  You _can't_ do that sysfs.  Static kobject in
> a module is a bug.  Period.

Are you trying to say that a device_register in module_init and a
device_unregister in module_exit is not allowed? Because if you
do a kmalloc/kfree to get the memory for your object or allocate
it statically is irrelevant if the release function is part of the
module you are trying to unload.

blue skies,
   Martin


