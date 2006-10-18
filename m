Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945895AbWJRWfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945895AbWJRWfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945898AbWJRWfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:35:20 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:21681 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1945895AbWJRWfT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:35:19 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-13.tower-29.messagelabs.com!1161210918!32464014!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: kernel oops with extended serial stuff turned on...
Date: Wed, 18 Oct 2006 17:35:17 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F803FE8@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel oops with extended serial stuff turned on...
Thread-Index: AcbzBOZ3Sp7s95zkTIiU47Rel4wjwAAAA9Yg
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Greg KH" <greg@kroah.com>
Cc: <Greg.Chandler@wellsfargo.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Oct 2006 22:35:18.0351 (UTC) FILETIME=[B03865F0:01C6F305]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> 
> I don't understand, what problem is occuring here?  Who is trying to
> register with sysfs twice?
> 
> thanks,
> 
> greg k-h
> 

The original warning/error he gets is:

> kobject_add failed for ttyM0 with -EEXIST, don't try to register
things
> with the same name in the same directory.

Presumably this means that "ttyM0" was already registered with
sysfs/udev already...

In my out-of-tree driver's case, I used to use "TTY_DRIVER_NO_DEVFS" as
a flag.

When that flag went away, I did not put in "TTY_DRIVER_DYNAMIC_DEV" by
mistake,
and I got the same error as Greg C.
I had to push in "TTY_DRIVER_DYNAMIC_DEV" to fix my problem...

I don't know much (anything) about the isicom.c driver, so maybe I am
reading
something into that error that shouldn't be read into it...

Scott
