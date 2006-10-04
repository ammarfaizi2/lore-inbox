Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWJDNKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWJDNKJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWJDNKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:10:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5033 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932411AbWJDNKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:10:07 -0400
Message-ID: <4523B2A8.6030509@garzik.org>
Date: Wed, 04 Oct 2006 09:10:00 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/partitions/check: add sysfs error handling
References: <20061004121900.GA23988@havoc.gtf.org> <20061004122631.GJ29920@ftp.linux.org.uk>
In-Reply-To: <20061004122631.GJ29920@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Wed, Oct 04, 2006 at 08:19:00AM -0400, Jeff Garzik wrote:
>> Handle errors thrown in disk_sysfs_symlinks(), and propagate back
>> to caller.
>>
>> The callers and associated functions don't do a real good job
>> of handling kobject errors anyway (add_partition, register_disk,
>> rescan_partitions), so this should do until something better comes
>> along.
> 
> I'm not sure that failure to create these symlinks should be fatal,
> to be honest...

Fair enough, though FWIW the failure is almost always -EFAULT or 
-ENOMEM, i.e. -ESYSTEMINTROUBLE...

	Jeff



