Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbUBFQnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 11:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbUBFQnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 11:43:10 -0500
Received: from fmr09.intel.com ([192.52.57.35]:15067 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S265505AbUBFQnH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 11:43:07 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Fri, 6 Feb 2004 08:42:14 -0800
Message-ID: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Thread-Index: AcPsThRFHV90aoLxSTaIErPsVWU6SwAezrdw
From: "Hefty, Sean" <sean.hefty@intel.com>
To: "Troy Benjegerdes" <hozer@hozed.org>
Cc: <infiniband-general@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Feb 2004 16:42:15.0108 (UTC) FILETIME=[2D224840:01C3ECD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 5, 2004 at 05:11:00PM -0800, Troy Benjegerdes wrote:
>On Thu, Feb 05, 2004 at 02:26:46PM -0800, Hefty, Sean wrote:
>> Personally, I'm amazed that professional developers have to discuss
or
>> defend modular, portable code.
>
>You're new to linux-kernel, aren't you? ;)

I was not trying to be condescending.  My point was that I think that
everyone on this list knows the purpose and benefits behind an
abstraction layer.  It's not something that needed to be discussed any
further.

I also understand that code in the Linux 2.6 kernel does not need
certain abstractions.  And I agree that because we are targeting the 2.6
kernel specifically, the existing code, some of which was developed 3-5
years ago, should be updated based on what the 2.6 kernel provides.

We want to continue to discuss specific details about what's needed to
add the code into the kernel.  Here's a list of modifications that I
think are needed so far:

* Update the code to make direct calls for atomic operations.
* Verify the use of spinlock calls.
* Reformat the code for tab spacing and curly brace usage.
* Elimination of typedefs.

And, yes, knowing some of these issues up front will save the trouble of
submitting code that will be immediately rejected.
