Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVCNSeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVCNSeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVCNSeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:34:24 -0500
Received: from fmr20.intel.com ([134.134.136.19]:20170 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261659AbVCNSeU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:34:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Date: Mon, 14 Mar 2005 10:34:15 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408070BAE@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUm2jNFoybHcdnXRiis+UL/glWmBgB6RvrA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>, "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 14 Mar 2005 18:34:16.0629 (UTC) FILETIME=[6D887E50:01C528C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 11, 2005 11:21 PM Greg KH wrote:
>> 
>> -	Report the errors to user.
>>
>This is done through the syslog, right?  Is that acceptable?

Reporting the errors to user can be written automatically to
/var/log/messages or be manually consumed through the syslog. I am not
sure whether it is acceptable or not, but I like your below suggestion. 

>It looks like you are logging a lot of stuff, all without a kernel log
>level, which is going to really mess up syslog parsers.
>
>Have you thought about just providing userspace with access to the
error
>message, in binary form, from a sysfs file, and causing a kevent to
wake
>userspace up to know to read from the file?  That way all of the
parsing
>of the error log can be done in userspace, and there is no formatting
of
>the messages from within the kernel.

Again, I like this suggestion.

Thanks,
Long
