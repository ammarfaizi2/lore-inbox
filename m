Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282358AbRKXD5B>; Fri, 23 Nov 2001 22:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282360AbRKXD4w>; Fri, 23 Nov 2001 22:56:52 -0500
Received: from air-1.osdl.org ([65.201.151.5]:51464 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S282358AbRKXD4r>;
	Fri, 23 Nov 2001 22:56:47 -0500
Message-ID: <3BFF19B0.F8D56E74@osdl.org>
Date: Fri, 23 Nov 2001 19:53:20 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Disabling FPU, MMX, SSE units?
In-Reply-To: <Pine.GSO.3.96.1011122120030.29116A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> On Wed, 21 Nov 2001, Pavel Machek wrote:
> 
> > Is there way not to let linux use FPU, MMX, SSE and similar fancy
> > units? I have athlon processor, but would like to turn FPU (and
> > similar fancy stuff) off...
> 
>  You may use "no387" to disable FPU and MMX (they are controlled by a
> single bit in cr0).  No idea about SSE.

Looks to me like another candidate for the setup/bugs/cpuid
processor-type splitting/cleanup that DaveJ et al have mentioned
[for 2.5 ?].

include/asm-i386/bugs.h is the only header file in linux/ that
contains^W hides __setup() parameters, and that's bad IMO.

~Randy
