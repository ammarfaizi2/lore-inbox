Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbSLDS3m>; Wed, 4 Dec 2002 13:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbSLDS3m>; Wed, 4 Dec 2002 13:29:42 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:20747 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267023AbSLDS3l>; Wed, 4 Dec 2002 13:29:41 -0500
Date: Wed, 4 Dec 2002 19:37:10 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021204183710.GA4004@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20021204113419.GA20282@merlin.emma.line.org> <20021204142628.GE26745@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204142628.GE26745@riesen-pc.gr05.synopsys.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Dec 2002, Alex Riesen wrote:

> > SuSE Linux 7.0, 7.3, 8.1 (2.4.19 kernel, binfmt_script.c identical to
> > 2.4.20 BK):
> > $ /tmp/try.pl
> > /bin/sh: -- # -*- perl -*- -T: invalid option
> 
> looks correct.

Nope. It cannot be correct if it breaks compatibility without giving us
any advantage.

> The interpreter (/bin/sh) has got everything after
> its name. IOW: "-- # -*- perl -*- -T"

Yes, as SINGLE argument. Therefore, Perl programs break if they use this
procedure recommended by "man perlrun".

I don't care WHY it works everywhere else, I want this incompatibility
fixed and I'm not going through a flame war as with the 4.4BSD
SIOCGIFNETMASK issue again. This is not negotiable.

BTW, 2.2 is also affected.

Think of someone using /usr/bin/env -i /path/to/program -- won't work on
Linux, but works on FreeBSD.

I cannot see technical reasons why this should remain unfixed.

We have enough braindead frivulous incompatibilities in Linux.

> It's just solaris' shell (/bin/sh) just ignores options starting with
> "--". And freebsd's as well.
> Anyway - it's bash, not the bin_fmt.

Nope, zsh as /bin/sh complains as well:

/bin/sh: no such option:  # _*_ perl _*_ _T

so does pdksh:

/bin/sh: /bin/sh: --: unknown option

