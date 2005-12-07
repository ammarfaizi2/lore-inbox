Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbVLGXTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbVLGXTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVLGXTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:19:38 -0500
Received: from fmr18.intel.com ([134.134.136.17]:442 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030443AbVLGXTg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:19:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC]add ACPI hooks for IDE suspend/resume
Date: Thu, 8 Dec 2005 07:19:16 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F101082733@pdsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC]add ACPI hooks for IDE suspend/resume
thread-index: AcX7gHGfQQCywDt1TqayEFuQcbA2rwAA6J0Q
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>, "Pavel Machek" <pavel@ucw.cz>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       "linux-ide" <linux-ide@vger.kernel.org>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>, "akpm" <akpm@osdl.org>
X-OriginalArrivalTime: 07 Dec 2005 23:19:21.0096 (UTC) FILETIME=[A74C0880:01C5FB84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>
>On Wed, Dec 07, 2005 at 11:43:23PM +0100, Pavel Machek wrote:
>
>> If someone swapped the drive while runtime, it would not be true,
too,
>> I guess. But that would be stupid thing to do. Swapping drive during
>> suspend-to-RAM would be similary stupid. During suspend-to-disk, it
>> might theoretically work, but we have big warnings saying "don't do
>> that".
>
>ACPI systems tend to fire ACPI notifications when a drive is ejected
>(and sometimes when you're preparing to eject them, depending on the
>system), which ought to make hotswap possible. I'm looking at
>integrating support for that into libata right now.
If the system supports S3/S4 hotswap, the corresponding ACPI resume
method
(_WAK in this case) will notify the hotswaped devices, so if the driver
can
handle the event, there is no problem for hotswap in suspend/resume.

Thanks,
Shaohua
