Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSCROIL>; Mon, 18 Mar 2002 09:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310920AbSCROHA>; Mon, 18 Mar 2002 09:07:00 -0500
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:58859 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S310917AbSCROG4> convert rfc822-to-8bit; Mon, 18 Mar 2002 09:06:56 -0500
Importance: Normal
Sensitivity: 
Subject: Re: 2.4.19-pre3 s390 ret_from_fork patch
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF0B4E478D.55DD4333-ONC1256B80.00443165@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 18 Mar 2002 15:04:09 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 18/03/2002 15:06:47
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The 2.4.19-pre3 works just dandy as it is without this patch,
>but it is needed for O(1) scheduler. I think Martin was going
>to forward this into 2.5.x tree, where O(1) is standard.
>
>The problem is that schedule_tail() is supposed to unlock
>runqueue, but if interrupts are enabled before that happens,
>a timer tick may squeeze in and deadlock. I observed such
>situation myself.
>
>So, I would like this to be in 2.4.19 for the sake of O(1) users.
>Any objections?

No, not really. My fix for 2.5.6 simply removes the stosm because
the sysc_return will disable the interrupts soon after anyway.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


