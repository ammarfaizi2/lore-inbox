Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279315AbRJZVd6>; Fri, 26 Oct 2001 17:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279332AbRJZVds>; Fri, 26 Oct 2001 17:33:48 -0400
Received: from air-1.osdl.org ([65.201.151.5]:58889 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S279315AbRJZVdp>;
	Fri, 26 Oct 2001 17:33:45 -0400
Message-ID: <3BD9D50E.859FC@osdl.org>
Date: Fri, 26 Oct 2001 14:26:38 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch to read/parse the MPC oem tables
In-Reply-To: <3372752995.1004100132@[10.10.1.2]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> >> This patch will parse the OEM extensions to the mps tables
> >> (if present). This gives me a mapping to tell which device
> >> lies in which NUMA node (the current code just guesses).
> >
> > So these extensions are OEM-specific, not part of the MP spec,
> > right?
> 
> As I understand this, the concept of OEM extensions is inside
> the MPS spec (there's a pointer for it inside the main table),
> though what's actually contained therein is OEM specific.

Right/agreed.  I didn't mean to imply that OEM extensions were
new, just that their contents are OEM-specific and not part
of the spec.

> > Also, could the array of structs <mp_irqs and mp_ioapics> (in
> > mpparse.c) be made __initdata, so that they could be discarded
> > after init?
> 
> Probably, but they're used in lots of places, so it would take some
> research to figure out all the possible combinations ;-) I'll leave that
> possiblity for a seperate patch (the structures were there already
> like this).

Right. :)

> A patch is attached below to fix these issues, plus one other bit
> of idiocy I found - I'd accidentally reduced the number of
> MAX_IRQ_SOURCES (I think I pulled the change forward from
> an older kernel, and dropped someone's fix. Oops).

Looks sane to me.

Thanks,
~Randy
