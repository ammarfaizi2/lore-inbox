Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131573AbRAOVmE>; Mon, 15 Jan 2001 16:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131683AbRAOVly>; Mon, 15 Jan 2001 16:41:54 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1555 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131573AbRAOVlh>; Mon, 15 Jan 2001 16:41:37 -0500
Message-ID: <3A636E77.3A409B17@transmeta.com>
Date: Mon, 15 Jan 2001 13:41:11 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386/setup.c cpuinfo notsc
In-Reply-To: <Pine.GSO.3.96.1010115223503.16619b-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> On Mon, 15 Jan 2001, H. Peter Anvin wrote:
> 
> > I would personally prefer to export the global flags separately from the
> > per-CPU flags.  Not only is it more correct, it would help catch these
> > kinds of bugs!!!
> 
>  That's what I am going to do.  Basically to recode cpu_has_* macros to
> use global flags as that's the intuitive name and use a set of different
> names for the SMP bootstrap code to access boot_cpu_data (possibly
> boot_has_* or boot_cpu_has_*).
> 

Right, but I'd also like to see the global flags exported explicitly to
/proc/cpuinfo.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
