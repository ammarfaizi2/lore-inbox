Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSDLHdR>; Fri, 12 Apr 2002 03:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSDLHdQ>; Fri, 12 Apr 2002 03:33:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60738 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313416AbSDLHdP>; Fri, 12 Apr 2002 03:33:15 -0400
To: Padraig Brady <padraig@antefacto.com>
Cc: timk@advfn.com, linux-kernel@vger.kernel.org
Subject: Re: R/W compressed fs support??
In-Reply-To: <200204101306.g3AD67s01683@mail.advfn.com>
	<3CB4824D.2030509@antefacto.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Apr 2002 01:26:03 -0600
Message-ID: <m1d6x5l6no.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig Brady <padraig@antefacto.com> writes:

> e2compr for 2.4 is being implemented by alcatel (France).
> I've successfully used it with 2.4.16 (against filesystems
> created with the 2.2 version). although I haven't stressed
> it yet. "Denis Richard" <dri@sxb.bsf.alcatel.fr> should
> have more info (and the 769777 byte patch).
> 
> Padraig.
> 
> Tim Kay wrote:
> > Hello,
> > 	Does anyone know of a Linux equivalent to DoubleSpace or whatever that
> > allows you read and _write_ to a compressed partiton or filesystem (in a way
> > that is transparent to the progs using the fs). I know there was e2compr but
> > that doesn't seem to have been touched in nearly 2 years, and is 2.2 specific,
> 
> > Infotec and the CBD patch seem to have died and zlibc seems to be a read only
> > solution. I'd have thought this would have been a biggie for embedded device
> > people but there doesn't seem to be anything out there. 	Any pointers
> > greatfully received....
> > T.I.A.
> > Tim

To do this efficiently this requires allocate on write support which
is just being developed for the kernel.  But the dirty data in the page
cache certainly helps.  And since the 2.2.x code didn't use the page cache
it was a challenge to port forward.  For most users disks have gotten
so big that it isn't much of an issue anymore.

Though seeing as I have filled my 20GB disk with code it might be worth
taking a look at.

Eric
