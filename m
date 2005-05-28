Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVE1LTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVE1LTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 07:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVE1LTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 07:19:16 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:23660 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262705AbVE1LTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 07:19:00 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch 4/8] irq code: Add coherence test for PREEMPT_ACTIVE
Date: Sat, 28 May 2005 13:21:02 +0200
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org,
       dhowells@redhat.com
References: <20050527003843.433BA1AEE88@zion.home.lan> <200505270306.09425.blaisorblade@yahoo.it> <20050527033126.GH1329@linux-sh.org>
In-Reply-To: <20050527033126.GH1329@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281321.03246.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 05:31, Paul Mundt wrote:
> On Fri, May 27, 2005 at 03:06:09AM +0200, Blaisorblade wrote:
> > On Friday 27 May 2005 02:38, blaisorblade@yahoo.it wrote:

> > Ok, a grep shows that possible culprits (i.e. giving success to
> > grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as
> > PREEMPT_ACTIVE, as given by grep PREEMPT_ACTIVE
> > include/asm-*/thread_info.h) are (at a first glance): frv, sh, sh64.

> Yeah, that's bogus for sh and sh64 anyways, this should do it.

> It would be nice to move PRREMPT_ACTIVE so it isn't per-arch anymore,
> there's not many users that use a different value (at least for the ones
> using generic hardirqs, ia64 seems to be the only one?).

Then in the generic headers
#ifndef PREEMPT_ACTIVE
#define PREEMPT_ACTIVE <the right value>
#else
<do the above coherence test>
#endif
Would be ok, right?
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
