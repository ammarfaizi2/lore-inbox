Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946052AbWGOOnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946052AbWGOOnE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 10:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946053AbWGOOnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 10:43:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3006 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946052AbWGOOnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 10:43:03 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Arjan van de Ven <arjan@infradead.org>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152973159.6374.59.camel@idefix.homelinux.org>
References: <1152663825.27958.5.camel@localhost>
	 <1152809039.8237.48.camel@mindpipe>
	 <1152869952.6374.8.camel@idefix.homelinux.org>
	 <Pine.LNX.4.64.0607142037110.13100@localhost.localdomain>
	 <1152919240.6374.38.camel@idefix.homelinux.org>
	 <1152971896.16617.4.camel@mindpipe>
	 <1152973159.6374.59.camel@idefix.homelinux.org>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 16:42:57 +0200
Message-Id: <1152974578.3114.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-16 at 00:19 +1000, Jean-Marc Valin wrote:
> > Non-root RT tasks are not "unprivileged" - they have a level of
> > privileges between a normal user and root.  Really I think it's OK for
> > these tasks to consume 100% CPU, as the admin has explicitly allowed it.
> 
> Sure, if the admin has allowed it, but I think it's also OK for desktop
> users to have access to rt scheduling by default, as long as their tasks
> are "well-behaved" (i.e. only use a few percent CPU).
> 
> > The only problem is that Ubuntu shipped with this enabled for everyone.
> 
> The problem is not the fact that it's enabled, but the fact that the
> amount of CPU allowed isn't restricted.

as long as you can fork and exec as many of those processes as you want
a per process rlimit is useless security wise... an evil user just fires
off a second process just before the first one gets killed and a non-RT
root still is starved out.


