Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUKRUAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUKRUAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUKRTyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:54:12 -0500
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:23544 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S262952AbUKRTwT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:52:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] handle quoted module parameters
Date: Thu, 18 Nov 2004 12:52:16 -0700
Message-ID: <08A354A3A9CCA24F9EE9BE13600CFBC50F85F2@wcosmb07.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] handle quoted module parameters
Thread-Index: AcTKsIQ0ZCY8BBt7SRqghWyefPYr6QC9x7Bw
From: <yiding_wang@agilent.com>
To: <rusty@rustcorp.com.au>, <rddunlap@osdl.org>
Cc: <yiding_wang@agilent.com>, <arjan@infradead.org>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-OriginalArrivalTime: 18 Nov 2004 19:52:17.0031 (UTC) FILETIME=[1B5A2970:01C4CDA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rusty,

The broken part I encountered is from the latest module-init-tools 3.1. Is that possible to restore the allowable parameter length as it for 2.4.x, at least increase it from 1K to 4K?

Regards,

Eddie

-----Original Message-----
From: Rusty Russell [mailto:rusty@rustcorp.com.au]
Sent: Sunday, November 14, 2004 5:15 PM
To: Randy.Dunlap
Cc: yiding_wang@agilent.com; arjan@infradead.org; lkml - Kernel Mailing
List; Andrew Morton
Subject: Re: [PATCH] handle quoted module parameters


On Thu, 2004-11-11 at 20:16 -0800, Randy.Dunlap wrote: 
> Here's a patch with better description.
> 
> 
> Fix module parameter quote handling.
> Module parameter strings (with spaces) are quoted like so:
> "modprm=this test"
> and not like this:
> modprm="this test"

Well, the quote handling in insmod was ripped out after 3.0, exactly
because it was broken like this.  But modprobe will use the latter form,
since it will paste it straight from the modprobe.conf file (which needs
quotes in options lines).

Hope that clarifies,
Rusty.
PS. module-init-tools 3.1 just out...
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

