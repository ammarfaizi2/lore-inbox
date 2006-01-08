Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752674AbWAHSSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbWAHSSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbWAHSSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:18:43 -0500
Received: from fmr14.intel.com ([192.55.52.68]:29119 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1752671AbWAHSSm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:18:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.15-mm2
Date: Sun, 8 Jan 2006 13:18:29 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A134FE@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.15-mm2
Thread-Index: AcYUTsDFLOzJOE8GQfafuaCXHtpDRAAMAATw
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Brice Goglin" <Brice.Goglin@ens-lyon.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2006 18:18:32.0261 (UTC) FILETIME=[EE925F50:01C6147F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> 2.6.15 and 2.6.15-git3 both don't show any of these issues. 
>> Did acpi and cpufreq get merged after -git3 ?
>> 
>
>Well whatever bug it is, it's in Linus's tree now.  Happens for me too.
>
>I traced the failure down as far as acpi_processor_get_performance_info(),
>where it's failing here:
>
>	status = acpi_get_handle(pr->handle, "_PCT", &handle);
>	if (ACPI_FAILURE(status)) {
>		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>				  "ACPI-based processor 
>performance control unavailable\n"));
>		return_VALUE(-ENODEV);
>	}

No, acpi was not merged after 2.6.15 -- see if cpufreq changed.

-Len
