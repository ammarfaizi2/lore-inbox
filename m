Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVEJHw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVEJHw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 03:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVEJHwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 03:52:55 -0400
Received: from general.keba.co.at ([193.154.24.243]:40289 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261571AbVEJHwu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 03:52:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Debuggers for RT (was: Real-Time Preemption: Magic Sysrq p doesn't work)
Date: Tue, 10 May 2005 09:52:47 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323206@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Debuggers for RT (was: Real-Time Preemption: Magic Sysrq p doesn't work)
Thread-Index: AcVUn9unJLMCbvBBS9CZcwNpJSH1sAAkw8DQ
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "Lee Revell" <rlrevell@joe-job.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * kus Kusche Klaus <kus@keba.com> wrote:
> 
> > I've been asked to analyze the various tools and possibilities 
> > available to debug an RT kernel.
> > 
> > * kgdb and kdb seem to be deeply incompatible with the RT 
> patches (they
> > mess with the scheduler, interrupts etc.), applying their 
> patches to an
> > RT tree fails quite impressively.
> 
> kgdb is in the -mm tree, and there are periodic ports to the 
> -mm tree. 
> Someone used it too on PREEMPT_RT - with some success. 
> There's no deep 
> incompatibility with the -RT kernel - just line-for-line collisions.
> 
> 	Ingo

Hmmm, kgdb is currently out of reach for me: The latest downloadable
kgdb tar archive is for 2.6.7, and I can't access the CVS repository
(our firewall only allows http:80 and ftp). Does anyone have a
downloadable current version?

I tried KDB with 2.6.12-rc2 and RT 7.45-01. It patches fine (except for
one trivial reject), compiles fine, boots fine, but freezes immediately
and completely when actually entering kdb. Power off is the only way
out...

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
