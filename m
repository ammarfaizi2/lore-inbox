Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291842AbSBNTPv>; Thu, 14 Feb 2002 14:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291843AbSBNTPl>; Thu, 14 Feb 2002 14:15:41 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:30216 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S291842AbSBNTPc>; Thu, 14 Feb 2002 14:15:32 -0500
Date: Thu, 14 Feb 2002 20:15:23 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Nick Craig-Wood <ncw@axis.demon.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-pre9: iptables screwed?
Message-ID: <20020214191523.GA30874@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com> <20020208094649.J26676@sunbeam.de.gnumonks.org> <20020214161225.A2867@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020214161225.A2867@axis.demon.co.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 04:12:25PM +0000, Nick Craig-Wood wrote:

> > > iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
> > > `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> > > Abort (core dumped)
> 
> I've noticed this too.
[...]
> Apologies if this info is too late but I didn't see a followup to
> lkml.

There were several followups on lkml, search the archives.

The final solution was to rebuild the userspace tools with the
-DNODEBUG make flag (the RH RPM was build with debug enabled due
to a CFLAGS override in the .spec).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
