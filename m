Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263460AbUDUQhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUDUQhz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUDUQhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:37:55 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:57993 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S263460AbUDUQhw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:37:52 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF9B34CCE6.C0CD3DC5-ONC1256E7D.005B1592-C1256E7D.005B528B@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 21 Apr 2004 18:37:29 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 21/04/2004 18:37:31
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> > This would mean that all other arches need to do the above three
> > statements in rcu_start_batch. If this is acceptable we certainly
> > can introduce a global idle_cpu_mask. Where? sched.c?
>
> My hope was gcc would actually optimize it away if it was a CPP constant
> instead of a variable.

Now I got it. You want to introduce a generic idle_cpu_mask which is a
#define to CPU_MASK_NONE and only an exploiter would use a real variable.
This is just a matter of test. I'll give it a try.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


