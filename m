Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130993AbRACUQv>; Wed, 3 Jan 2001 15:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130916AbRACUQb>; Wed, 3 Jan 2001 15:16:31 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:17093 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130913AbRACUQ2>; Wed, 3 Jan 2001 15:16:28 -0500
To: Craig Schlenter <craig@qualica.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange swap behaviour - test11pre4
In-Reply-To: <20010103123230.C23323@qualica.com>
	<20010103160802.A8544@qualica.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <20010103160802.A8544@qualica.com>
Message-ID: <m3ofxo35tz.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 03 Jan 2001 20:49:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Schlenter <craig@qualica.com> writes:

> [snip, vmstat stuff, me]
> > There is a perl program running (80 Meg's in size, 20 Megs
> > resident) that is chatting to a database and building up a large
> > hash in memory. The machine has 64M of RAM. The bit that doesn't
> > make sense is why the cache is so large - the VM seems to have got
> > stuck paging in stuff from swap repeatedly (bits of the perl
> > program it would seem). Surely it should shrink the cache to
> > provide more breathing room or am I being an idiot about this?
> 
> $idiot++;

You probably got fooled by the new vm: All shm pages are now in the
page cache and thus appear as 'cached'. But they cannot be shrinked
away...

So I would vote for $idiot--; ;-)

Greetings
                Christoph

P.S: I expect this to become an FAQ

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
