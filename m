Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946064AbWGOPEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946064AbWGOPEU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 11:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946065AbWGOPEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 11:04:20 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:23735 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S1946060AbWGOPET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 11:04:19 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152974578.3114.24.camel@laptopd505.fenrus.org>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
	 <1152919240.6374.38.camel@idefix.homelinux.org>
	 <1152971896.16617.4.camel@mindpipe>
	 <1152973159.6374.59.camel@idefix.homelinux.org>
	 <1152974578.3114.24.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Sun, 16 Jul 2006 01:04:17 +1000
Message-Id: <1152975857.6374.65.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as long as you can fork and exec as many of those processes as you want
> a per process rlimit is useless security wise... an evil user just fires
> off a second process just before the first one gets killed and a non-RT
> root still is starved out.

Of course, which is why the idea is for the limit to be global, across
all non-root users. AFAIK, that's what Ingo's original (pre-2.6.12)
patch did and also what Con Kolivas' SCHED_ISO patch does. That's also
why I think it would be very hard (if possible at all) to do this in
user space.

	Jean-Marc
