Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVFBBXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVFBBXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVFBBXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:23:08 -0400
Received: from fmr19.intel.com ([134.134.136.18]:40111 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261553AbVFBBW5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:22:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Abstracted Priority Inheritance for RT
Date: Wed, 1 Jun 2005 18:22:22 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A036671E5@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Abstracted Priority Inheritance for RT
Thread-Index: AcVnCaU4MPbelU/7SluTKHuJJycVXQAA9QjQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <dwalker@mvista.com>
Cc: "Esben Nielsen" <simlo@phys.au.dk>, "Ingo Molnar" <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <sdietrich@mvista.com>,
       <rostedt@goodmis.org>
X-OriginalArrivalTime: 02 Jun 2005 01:22:24.0432 (UTC) FILETIME=[8808F300:01C56711]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Daniel Walker [mailto:dwalker@mvista.com]
>On Wed, 2005-06-01 at 17:10 -0700, Perez-Gonzalez, Inaky wrote:
>
>> Maybe he is referring to the case?
>>
>> A owns M
>> B owns N and is waiting for M
>> A is trying to wait for N
>>
>> These deadlocking cases can be tricky during PI.
>
>The bulk of the code is from the current RT mutex, so I'm assuming it
>handles this case correctly. However, the rt mutex isn't in userspace ,
>so task A or B was a user space task , then the problem would need to
be
>explored.. How does PI change if A or B are user space tasks?

It doesn't matter in which space the tasks are, a deadlock 
condition can happen anywhere and that can easily lead to 
infinite recursion/iteration (as bad). I seem to remember Ingo
mentioning he had taken care of full transitivity (or maybe it
was somebody else saying it).

-- Inaky
