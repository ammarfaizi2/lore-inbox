Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUH0Sot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUH0Sot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUH0Sot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:44:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2511 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267232AbUH0So3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:44:29 -0400
Subject: Re: silent semantic changes with reiser4
From: Lee Revell <rlrevell@joe-job.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Rik van Riel <riel@redhat.com>, David Masover <ninja@slaphack.com>,
       Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com
In-Reply-To: <412F7D22.5050101@namesys.com>
References: <Pine.LNX.4.44.0408271010300.10272-100000@chimarrao.boston.redhat.com>
	 <412F7D22.5050101@namesys.com>
Content-Type: text/plain
Message-Id: <1093632269.837.59.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 14:44:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 14:27, Hans Reiser wrote:
> Rik van Riel wrote:
> >On Fri, 27 Aug 2004, Hans Reiser wrote:
> >
> >>Why are you guys even considering going to any pain at all to distort 
> >>semantics for the sake of backup?  tar is easy, we'll fix it and send in 
> >>a patch. 
> >
> >Because not everybody uses tar.  Quite a few people use a
> >network backup system, while others use duplicity, RPM uses
> >cpio internally and big companies tend to use proprietary
> >network backup suites.
> >
> >Breaking people's setup is something to worry about.
> >
> It is the tail that should not wag the dog.  New semantics are going to 
> break backups other than dd.   We need a LOT of new semantics if we 
> don't want to be inferior to Apple and MS.
> 
> We should implement backup plugin methods though, so that we only have 
> to break things once....

Every Linux shop I know of uses amanda anyway, which will not be
affected by these changes, as it uses dump/restore.  restore will need
minor changes, I think dump might not have to be changed at all.

If your backup system can't easily handle these changes, that's a pretty
good indication that it's poorly designed.

Lee

