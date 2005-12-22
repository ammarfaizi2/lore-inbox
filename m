Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVLVQbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVLVQbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVLVQbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:31:51 -0500
Received: from magic.adaptec.com ([216.52.22.17]:21380 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965161AbVLVQbv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:31:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: scsi errors with dpt-i2o driver
Date: Thu, 22 Dec 2005 11:31:41 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01FB3AC6@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: scsi errors with dpt-i2o driver
Thread-Index: AcYHBiurGzkmAqRVSfetAeHCrq4vZQADXQ4A
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Kenny Simpson" <theonetruekenny@yahoo.com>,
       "linux kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are issues being reported by the firmware in the adapter, looks
like you have a bad drive. Since the adapter 'hides' the physical
devices behind arrays. The array associated with id 9 is whining, but I
do not know which physical is being naughty.

A driver change will make no difference, use the management applications
to discover which target is misbehaving, probably would not hurt to
contact Adaptec technical support, especially if you have an
incompatible drive (often can be fixed by a firmware update to the
drive). They also can help you through the cookbook discovery of cable
and setting issues.

Sincerely -- Mark Salyzyn

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Kenny Simpson
> Sent: Thursday, December 22, 2005 9:44 AM
> To: linux kernel
> Subject: scsi errors with dpt-i2o driver
> 
> 
> Hi,
>   We have been experiencing long system pauses (~30 seconds), 
> and think we have tracked it down to
> a scsi issue. The syslog just after the pause has:
> Dec 22 04:12:06 tux224 kernel: dpti0: Trying to Abort cmd=264682
> Dec 22 04:12:06 tux224 kernel: dpti0: Abort cmd not supported
> Dec 22 04:12:06 tux224 kernel: dpti0: Trying to Abort cmd=264683
> Dec 22 04:12:06 tux224 kernel: dpti0: Abort cmd not supported
> Dec 22 04:12:06 tux224 kernel: dpti0: Trying to Abort cmd=264684
> Dec 22 04:12:06 tux224 kernel: dpti0: Abort cmd not supported
> Dec 22 04:12:06 tux224 kernel: dpti0: Trying to reset device
> Dec 22 04:12:06 tux224 kernel: dpti0: Device reset not supported
> Dec 22 04:12:06 tux224 kernel: dpti0: Bus reset: SCSI Bus 0: tid: 9
> Dec 22 04:12:06 tux224 kernel: dpti0: Bus reset success.
