Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290791AbSAYS6m>; Fri, 25 Jan 2002 13:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290787AbSAYS6Z>; Fri, 25 Jan 2002 13:58:25 -0500
Received: from ns.suse.de ([213.95.15.193]:60422 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290797AbSAYS5H>;
	Fri, 25 Jan 2002 13:57:07 -0500
Date: Fri, 25 Jan 2002 19:57:06 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Gooch <rgooch@atnf.csiro.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
In-Reply-To: <E16UBUl-0003J9-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201251955250.31880-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, Alan Cox wrote:

> > just not do it on the right CPU (you're _not_ supposed to read to see if
> > you are writing the same value: MTRR's can at least in theory have
> > side-effects, so it's not the same check as for the microcode update).
> So why not just set it twice - surely that is harmless ? Why add complex
> code ?

I wondered the same thing of the microcode changes.
Since for the commoncase (ie, non-HT) it now has the side-effect of
doing this..

microcode: CPU0 updated from revision 7 to 7, date-10151999

which looks odd in comparison to the old "already current" msg.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

