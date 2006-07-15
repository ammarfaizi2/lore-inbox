Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWGOPoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWGOPoo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 11:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWGOPoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 11:44:44 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61894 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750709AbWGOPon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 11:44:43 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Lee Revell <rlrevell@joe-job.com>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152975857.6374.65.camel@idefix.homelinux.org>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
	 <1152919240.6374.38.camel@idefix.homelinux.org>
	 <1152971896.16617.4.camel@mindpipe>
	 <1152973159.6374.59.camel@idefix.homelinux.org>
	 <1152974578.3114.24.camel@laptopd505.fenrus.org>
	 <1152975857.6374.65.camel@idefix.homelinux.org>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 11:44:44 -0400
Message-Id: <1152978284.16617.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-16 at 01:04 +1000, Jean-Marc Valin wrote:
> > as long as you can fork and exec as many of those processes as you want
> > a per process rlimit is useless security wise... an evil user just fires
> > off a second process just before the first one gets killed and a non-RT
> > root still is starved out.
> 
> Of course, which is why the idea is for the limit to be global, across
> all non-root users. AFAIK, that's what Ingo's original (pre-2.6.12)
> patch did and also what Con Kolivas' SCHED_ISO patch does. That's also
> why I think it would be very hard (if possible at all) to do this in
> user space.

I don't think it's a problem.  If the admin does not want non-root users
to be able to lock up the machine, just don't put them in the realtime
group.

Lee

