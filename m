Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVGMIN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVGMIN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 04:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVGMIN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 04:13:56 -0400
Received: from fmr15.intel.com ([192.55.52.69]:43427 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S262632AbVGMINz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 04:13:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Merging relayfs?
Date: Wed, 13 Jul 2005 01:13:51 -0700
Message-ID: <2CB9B46A0690824693581340E23B4E100489170F@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Merging relayfs?
Thread-Index: AcWHY7290gR6I4moTA+4BAmOl9N4aAAGybow
From: "Spirakis, Charles" <charles.spirakis@intel.com>
To: "Vara Prasad" <prasadav@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jul 2005 08:13:52.0874 (UTC) FILETIME=[CE6DFCA0:01C58782]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe the Intel tool that Vara is referencing is the Vtune tool
(which has an open source, GPL'ed statistical sampling driver). It keeps
a trace history (instead of aggregating the data) that is passed into
user space so that it can do post processing analysis from user space.
The most common method of aggregating data for sampling/profiling is to
lose the time information of when a sample is taken (for example, that
is what oprofile does). For many people, this is fine. For others, they
want the time information so they can visualize the sequence of events.

Having relayfs merged into the kernel would allow us to have a
consistent and reliable way of passing the data we need from kernel
space into user space.

In essence, relayfs is a basic infrastructure upon which other tools can
be built - whether that's profiling, debugging, logging, etc.

-- charles

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Vara Prasad
> Sent: Tuesday, July 12, 2005 9:30 PM
> To: unlisted-recipients
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Merging relayfs?
> 
> *** snip ***
>
> There are tools like itrace and Intel has one (i forgot the 
> name) they would like to get the raw data into user space and 
> do all kinds of fancy statistical analysis, visualization 
> etc. Their value add is the analysis of the data. I am sure 
> you are not suggesting pushing capabilities of those tools to 
> the kernel, right.
> 
> As Steven Rostedt mentioned in his initial reply in this 
> thread, many of us have written adhoc buffering scheme 
> similar to what relayfs provides to debug kernel problems 
> that happen after a long running test, if such facility 
> already exists in the kernel everyone doesn't have to develop one.
> 
> I would like to see relayfs merged.
> 
> 
