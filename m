Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUFPAyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUFPAyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 20:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUFPAyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 20:54:54 -0400
Received: from fmr06.intel.com ([134.134.136.7]:10633 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266048AbUFPAyv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 20:54:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Announce] Non Invasive Kernel Monitor for threads/processes
Date: Tue, 15 Jun 2004 17:54:40 -0700
Message-ID: <66539F0E7F15B44C9C0FC50D0FF024F7B1A324@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Announce] Non Invasive Kernel Monitor for threads/processes
Thread-Index: AcRTOqOPP1jREwCeTWqH4eCeghgHyQAAUmBQ
From: "Sabharwal, Atul" <atul.sabharwal@intel.com>
To: "Chris Wright" <chrisw@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Jun 2004 00:54:42.0068 (UTC) FILETIME=[82321540:01C4533C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>* Atul Sabharwal (atul_sabharwal@linux.jf.intel.com) wrote:
>> We have been working with a solution for non-intrusively 
>trapping on lifetime
>> of processes/threads. This is useful for management 
>applications running in
>> telecom and enterprise data centers that need to monitor a 
>set of threads/
>> processes.
>> 
>> Project Goal::
>> ~~~~~~~~~~~~~~
>> To create a kernel patch that  shall support methods to 
>non-intrusively monitor
>> processes/threads at the kernel level.  It would use a 
>notfication mechanism in
>> the kernel that allows registration of events of interest 
>regarding processes/
>> threads.  Events of interest could be the following : 
>Process creation (fork), 
>> Process exit(exit), Process calls(exec), thread creation & 
>thread exit. 
>
>These spots are already hooked via LSM and audit (the latter is capable
>of communicating such events to userspace via netfilter) Was that not
>sufficient somehow?  In fact, the netfilter queuing will probably fair
>better than sigqueue which fairly limited.  Might be worth looking into
>that.  Did you look at the task ornament patch floating about 
>from David
>Howells?  If new code is needed, that patch looks more 
>generically useful.
>

How does auditing work in the event of a process failure ? There would
be
no system call triggered in that case.  Also, my initial thoughts are 
that the non-invasive Kmonitor is lesser performance impact when
compared
to auditing. I would spend some time developing sample code to confirm
it.

I have not looked at the task ornament patch. If you could send me a
link.
Thanks,

Atul
