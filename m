Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263671AbUD2IYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbUD2IYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUD2IYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:24:51 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:36304 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S263671AbUD2IYu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:24:50 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: dipankar@in.ibm.com
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF8DC2156F.441E947F-ONC1256E85.002E0C3D-C1256E85.002E2DB9@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 29 Apr 2004 10:24:23 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 29/04/2004 10:24:24
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> idle_cpu_mask does not really represent CPUs that are conventionally
> called "idle", it represents the ones that have hz timer switched
> off (in your patch). So, why not just call it nohz_cpu_mask ?
> RCU doesn't need an idle cpu mask, it has its own mechanism
> for detecting idle cpus, it just needs to know about the ones
> that have hz timers switched off. If you call it nohz_cpu_mask,
> then it would make sense to say that for systems which do not
> switch off hz timer, nohz_cpu_mask will always be CPU_MASK_NONE.

Ok, I don't really mind the name change. It's nohz_cpu_mask then.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


