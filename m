Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVEXJry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVEXJry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVEXJqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:46:52 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:51398 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S262009AbVEXJUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:20:36 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524092029.8F849FA33@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:20:29 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 58A23FB70

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:45 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261270AbVEXBs7 (ORCPT <rfc822;chiakotay@nexlab.it>);

	Mon, 23 May 2005 21:48:59 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVEXBs7

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Mon, 23 May 2005 21:48:59 -0400

Received: from fmr20.intel.com ([134.134.136.19]:30157 "EHLO

	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP

	id S261270AbVEXBsz convert rfc822-to-8bit (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Mon, 23 May 2005 21:48:55 -0400

Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])

	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j4O1mYt0028798;

	Tue, 24 May 2005 01:48:34 GMT

Received: from orsmsxvs040.jf.intel.com (orsmsxvs040.jf.intel.com [192.168.65.206])

	by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j4O1mTXf003520;

	Tue, 24 May 2005 01:48:33 GMT

Received: from orsmsx331.amr.corp.intel.com ([192.168.65.56])

 by orsmsxvs040.jf.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005052318483323882

 ; Mon, 23 May 2005 18:48:33 -0700

Received: from orsmsx407.amr.corp.intel.com ([192.168.65.50]) by orsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);

	 Mon, 23 May 2005 18:48:33 -0700

x-mimeole: Produced By Microsoft Exchange V6.5.7226.0

Content-class: urn:content-classes:message

MIME-Version: 1.0

Content-Type: text/plain;

	charset="us-ascii"

Subject: RE: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06

Date:	Mon, 23 May 2005 18:47:19 -0700

Message-ID: <F989B1573A3A644BAB3920FBECA4D25A0354AC06@orsmsx407>

X-MS-Has-Attach: 

X-MS-TNEF-Correlator: 

Thread-Topic: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06

Thread-Index: AcVfp8XeLo2UCHswQ3y8C8/NFsPwNwAWkJXg

From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Oleg Nesterov" <oleg@tv-sign.ru>, "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>,
	"Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 24 May 2005 01:48:33.0281 (UTC) FILETIME=[B16C8F10:01C56002]

X-Scanned-By: MIMEDefang 2.44

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org

Content-Transfer-Encoding: quoted-printable



>From: tmp@several.ru [mailto:tmp@several.ru] On Behalf Of Oleg Nesterov
>Ingo Molnar wrote:
>>
>> Changes:
>>
>>  - more plist fixes (Daniel Walker)

>Why should we consider ->prio =3D=3D INT_MAX as a special case?

This is a fusyn-specific optimization. INT_MAX is set to be the lowest
prio and the one used by non-PI waiters, so it will never interfere with
normal priorities. Because this is probably going to be most of the=20
cases and we know it will always be the last one, it is a shortcut for
it.

It makes some sense, but in a more generic scenario, I might not.

-- Inaky=20

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

