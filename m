Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVCKStr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVCKStr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCKSn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:43:59 -0500
Received: from fmr20.intel.com ([134.134.136.19]:9143 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261269AbVCKSYU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:24:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] PCI Express Advanced Error Reporting Driver
Date: Fri, 11 Mar 2005 10:24:15 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024080392EC@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUl+m4g7lDaIWxxTtKVLyXeewg1TAAa5T9A
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>, <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 11 Mar 2005 18:24:17.0172 (UTC) FILETIME=[88FD5D40:01C52667]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday, March 10, 2005 9:23 PM Greg KH wrote:
>> On Thu, Mar 10, 2005 at 03:04:18PM -0800, long wrote:
>> PCI Express error signaling can occur on the PCI Express link itself
>> or on behalf of transactions initiated on the link. PCI Express
>> defines the Advanced Error Reporting capability, which is implemented

>> with a PCI Express advanced error reporting extended capability
>> structure, to provide more robust error reporting. With the Advanced
>> Error Reporting capability a PCI Express component, which detects an
>> error, can send an error message to the Root Port associated with
>> its hierarchy.  

>This patch was too big for lkml, and should also be sent to the
>linux-pci list.  Care to split it up and resend it?

Will split it up and resend.

> Also, how does this tie into the recent discussion about pci error
> recovery?

The standard PCI Specification calls out SERR and PERR. I am not sure
about the recent discussion of PCI error of recovery. It is perhaps
regarding the possibility of recovering from a PERR or SERR. However,
PCI Express error occurs on the PCI Express link or on behalf of
transactions occurred on the PCI Express link. PCI Express component,
which implements PCI Express Advanced Error Reporting Capability, sends
error message to the Root Port to indicate error occurred on the PCI
Express link where it is connected. The PCI Express error recovery is on
behalf of attempting to do a PCI Express link recovery, not PCI error
recovery. It appears that PCI Express AER is disjoint from PCI error
recovery.

Thanks,
Long
