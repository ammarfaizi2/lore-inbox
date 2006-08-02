Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWHBFhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWHBFhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWHBFhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:37:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:6883 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751254AbWHBFhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:37:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TsWmQpLs+Dh/NhUyf8GnTsNgr+TsUaqRMNbUxoOCzGXH8y4U5QzS5QJAgcAQhP8HWwApJSuapbPSexHwPS47XWfGgsMmc8Zfyr55b/mbMo+d3dtYkkGKNK2L9eQ5ivSQUtkH8xTqC0aWe+k4FZ+4kxd2sa/WqOFrtaLU8KZ5MmU=
Message-ID: <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
Date: Tue, 1 Aug 2006 22:37:13 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.6.17-rt8
In-Reply-To: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying again.  Hopefully gmail will send as plain/text this time.
Ingo CC'd on the version with the text/html subpart (sorry).

I've just stuck up the relevant stuff on my little webserver at:

 http://66.93.162.103/~rcrocomb/lkml/

 The files are:

 config_2.6.17-rt8_local_00
 config_2.6.17-rt8_local_01
 dmesg_2.6.17-rt8_local_00_00
 linux_version_info
 output_from_lspci
 scooter_log

 which should largely be self-explanatory, I think.  The local_00
kernel does not have much in the way of debugging info turned on,
because I was hoping for peak performance.  local_01 has a bunch more
debug widgets enabled:

 +CONFIG_DEBUG_PREEMPT=y
 +CONFIG_PREEMPT_TRACE=y
 +CONFIG_DEBUG_INFO=y
 +CONFIG_FRAME_POINTER=y
 +CONFIG_UNWIND_INFO=y
 +CONFIG_FORCED_INLINING=y
 +CONFIG_IOMMU_DEBUG=y

 in the hope of providing better/more info.  The machine is 'scooter',
and scooter_log is the dump from 'cu' on another machine.  I decided
not to trim anything, since I wasn't sure what might/might not be
relevant.  Note that at first we were running with the nvidia kernel
module, but removed that later (scooter_log6 line 7142 or therebouts)
so as to test with an untainted kernel.  I wasn't sure if the problems
w/ the module would be of interest or not.

 I can pretty much guarantee problems with a kernel compile or two in parallel.

 The machine is built around the new IWill H8502 motherboard.  It's a
4-way 2.8GHz Opteron machine with 8GB of RAM and two 150GB SCSI disks
in a RAID5 setup.  The person doing development on this machine says
the problems are basically constant.  I am using a very similar
machine, but with dual video cards and 32GB of RAM, and haven't
experienced any problems.  That machine, too, is using the nvidia
module.  Oh, the underlying distribution is Fedora Core 5.

 I'll be glad to provide other info/run any patches/etc.

 Thanks.

 Oh, I'm not lkml subscribed, so please CC.

-- 
Robert Crocombe
rcrocomb@gmail.com
