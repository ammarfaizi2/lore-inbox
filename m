Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbREUMmP>; Mon, 21 May 2001 08:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbREUMmF>; Mon, 21 May 2001 08:42:05 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:63757 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261424AbREUMlu>;
	Mon, 21 May 2001 08:41:50 -0400
Date: Mon, 21 May 2001 14:41:41 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: const __init
Message-ID: <20010521144141.A4839@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.05.10105202210370.1667-100000@callisto.of.borg> <3B083878.1785C27D@mandrakesoft.com> <20010521001949.R754@nightmaster.csn.tu-chemnitz.de> <20010520194340.C19096@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010520194340.C19096@twiddle.net>; from rth@twiddle.net on Sun, May 20, 2001 at 07:43:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> No, the problem is not with which section, but what flags that
> section should have.  If you put only "const" data in a section,
> then the section should have SHF_WRITE clear.  Conversely, if
> you put writable data in a section then SHF_WRITE should be set.
> 
> Now, one could argue that gcc should scan the entire file to
> see if there are any non-constant data members added to a 
> particular section, and set SHF_WRITE if any such exist.
> 
> My answer is: you would not like gcc's memory usage under these
> conditions.

No, I'd argue that gcc should offer a `section_flags' attribute to be
used along with the `section' attribute.  Then we change the definition
of __init.

-- Jamie.
