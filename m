Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWJMGUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWJMGUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 02:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWJMGUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 02:20:06 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37866 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751159AbWJMGUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 02:20:03 -0400
Date: Fri, 13 Oct 2006 08:12:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Kosina <jikos@jikos.cz>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-git21, possible recursive locking in kseriod ends up in DWARF2 unwinder stuck
Message-ID: <20061013061234.GA15305@elte.hu>
References: <5a4c581d0610041417y113bb92cs10971308180980e5@mail.gmail.com> <Pine.LNX.4.64.0610042317590.12556@twin.jikos.cz> <d120d5000610051334o7604b1d4hd2f4c9a9b858f06e@mail.gmail.com> <1160134696.2792.102.camel@taijtu> <d120d5000610060629t63905294u194b72a9ad8c74f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000610060629t63905294u194b72a9ad8c74f2@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> >#define lockdep_set_subclass(lock, subclass) \
> > ({ static struct lock_key_class __key; \
> >    lockdep_init_map(&(lock)->dep_map, concat(lock, subclass), \
> >                     &__key, subclass); })
> 
> That leaves unneeded __key (another one was already created by 
> mutex_init...) but it tucked away nicely in the define so it is fine 
> by me.
> 
> Ingo, do you want to send these changes on or you want me to push them 
> through my tree?

could you send that commit to Andrew? It looks good to me, and the 
unavailability of the lockdep_set_subclass() API upstream is hindering 
Jiri now.

	Ingo
