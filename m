Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVEXBs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVEXBs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 21:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVEXBs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 21:48:59 -0400
Received: from fmr20.intel.com ([134.134.136.19]:30157 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261270AbVEXBsz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 21:48:55 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Date: Mon, 23 May 2005 18:47:19 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A0354AC06@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Thread-Index: AcVfp8XeLo2UCHswQ3y8C8/NFsPwNwAWkJXg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Oleg Nesterov" <oleg@tv-sign.ru>, "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 24 May 2005 01:48:33.0281 (UTC) FILETIME=[B16C8F10:01C56002]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: tmp@several.ru [mailto:tmp@several.ru] On Behalf Of Oleg Nesterov
>Ingo Molnar wrote:
>>
>> Changes:
>>
>>  - more plist fixes (Daniel Walker)

>Why should we consider ->prio == INT_MAX as a special case?

This is a fusyn-specific optimization. INT_MAX is set to be the lowest
prio and the one used by non-PI waiters, so it will never interfere with
normal priorities. Because this is probably going to be most of the 
cases and we know it will always be the last one, it is a shortcut for
it.

It makes some sense, but in a more generic scenario, I might not.

-- Inaky 

