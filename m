Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTJVSlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 14:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263454AbTJVSlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 14:41:42 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:57812 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S263420AbTJVSll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 14:41:41 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Wed, 22 Oct 2003 11:40:15 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EF66@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOYfWClDRqxfWkVQPWHaXBW1nMlHgATZuqA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Ducrot Bruno" <ducrot@poupinou.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 22 Oct 2003 18:40:16.0389 (UTC) FILETIME=[EFB4C350:01C398CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ducrot Bruno [mailto:ducrot@poupinou.org] 

> Looking around some other asl, it seems also that if you verify that
> _PCT return FFixedHW, but length and address are both different to 0,
> it may be possible that a generic driver via MSR could work, but there
> is nothing in specs afaik (and specs can be changed if compatible..).

My understanding was that if the operation region is FFixedHW, the
parameters are meaningless (and should be 0). FFixedHW means the OS
knows without ACPI telling it how to switch states. That is, while R40
lists the MSRs for the addresses, that is useless and confusing, because
the OS should a priori know via a driver how to switch, and therefore
isn't looking at those parameters.

Regards -- Andy
