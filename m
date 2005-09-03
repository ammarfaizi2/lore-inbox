Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVICP5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVICP5W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 11:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbVICP5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 11:57:22 -0400
Received: from fmr16.intel.com ([192.55.52.70]:31981 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751071AbVICP5V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 11:57:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.13-mm1: hangs during boot ...
Date: Sat, 3 Sep 2005 11:57:07 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30047FA090@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13-mm1: hangs during boot ...
Thread-Index: AcWwbPblSZIy5+xATe+kkSVNgkr/AAAMObXQ
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Peter Williams" <pwil3058@bigpond.net.au>
Cc: <linux-kernel@vger.kernel.org>, <James.Bottomley@steeleye.com>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 03 Sep 2005 15:57:10.0527 (UTC) FILETIME=[249A38F0:01C5B0A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Please then try the latest ACPI patch here:
>>  > 
>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches
>/release/2.6.13/acpi-20050902-2.6.13.diff.gz
>>  > It should apply to vanilla 2.6.13 with a reject in ia64/Kconfig
>>  > that you can ignore.
>>  > 
>>  > If this works, then we munged git-acpi.patch in 
>2.6.13-mm1 somehow.
>> 
>>  There were no problems with this patch applied.  So it 
>looks like the 
>>  munge theory is correct.
>
>That diff is significantly different from the diff I plucked from
>master.kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6
>.git#test
>for 2.6.13-mm1.
>
>Doing (patch -R | grep FAILED) on 2.6.13-mm1 says:

Right.
2.6.13/acpi-20050902-2.6.13.diff.gz
is newers than 2.6.13-rc1's git-acpi.patch

2.6.13/acpi-20050815-2.6.13.diff.gz
is a closer match -- though not exact.

Peter, it might be illustrative if you have a moment
if you can also test 2.6.13/acpi-20050815-2.6.13.diff.gz
all by itself.

If it fails, then I broke -mm1
with acpi-20050815-2.6.13.diff.gz, but fixed
it by acpi-20050902-2.6.13.diff.gz.

If it succeeds, then the issue lies in the relatively small delta
between acpi-20050815-2.6.13.diff.gz 2.6.13-mm1's git-acpi.patch.

thanks,
-Len

