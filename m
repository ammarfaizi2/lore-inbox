Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVDKWfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVDKWfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVDKWex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:34:53 -0400
Received: from fmr19.intel.com ([134.134.136.18]:226 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261978AbVDKWcv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:32:51 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Priority Lists for the RT mutex
Date: Mon, 11 Apr 2005 15:31:41 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02FA3AF6@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Priority Lists for the RT mutex
Thread-Index: AcU+5CXMp2SGQZGuTyiQeHcUB/07dgAAcU6Q
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Bill Huey \(hui\)" <bhuey@lnxw.com>, "Ingo Molnar" <mingo@elte.hu>
Cc: "Sven-Thorsten Dietrich" <sdietrich@mvista.com>,
       "Daniel Walker" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Joe Korty" <joe.korty@ccur.com>
X-OriginalArrivalTime: 11 Apr 2005 22:31:52.0225 (UTC) FILETIME=[4218D110:01C53EE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Bill Huey (hui) [mailto:bhuey@lnxw.com]
>
>On Mon, Apr 11, 2005 at 10:57:37AM +0200, Ingo Molnar wrote:
>>
>> * Perez-Gonzalez, Inaky <inaky.perez-gonzalez@intel.com> wrote:
>>
>> > Let me re-phrase then: it is a must have only on PI, to make sure
you
>> > don't have a loop when doing it. Maybe is a consequence of the
>> > algorithm I chose. -However- it should be possible to disable it in
>> > cases where you are reasonably sure it won't happen (such as kernel
>> > code). In any case, AFAIR, I still did not implement it.
>>
>> are there cases where userspace wants to disable deadlock-detection
for
>> its own locks?
>
>I'd disable it for userspace locks. There might be folks that want to
>implement userspace drivers, but I can't imagine it being 'ok' to have
>the kernel call out to userspace and have it block correctly. I would
>expect them to do something else that's less drastic.

If you are exposing the kernel locks to userspace to implement
mutexes (eg POSIX mutexes), deadlock checking is a feature you want
to have to complain with POSIX. According to some off the record
requirements I've been given, some applications badly need it (I have 
a hard time believing that they are so broken, but heck...).

-- Inaky
