Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268161AbTB1VOq>; Fri, 28 Feb 2003 16:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268165AbTB1VOq>; Fri, 28 Feb 2003 16:14:46 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6924 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S268161AbTB1VOo>;
	Fri, 28 Feb 2003 16:14:44 -0500
Date: Fri, 28 Feb 2003 22:25:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 423] New: make -j X bzImage gives a warning
Message-ID: <20030228212504.GA21843@mars.ravnborg.org>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <347860000.1046465385@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <347860000.1046465385@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 12:49:45PM -0800, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=423
> 
>            Summary: make -j X bzImage gives a warning
>     Kernel Version: 2.5.63
>             Status: NEW
>           Severity: low	
>              Owner: zippel@linux-m68k.org

Feel free to bug me with kbuild related issues.
In this area Roman is 'only' taking care of kconfig & related issues AFAIK.

> make -j X bzImage gives a warning:
> 
> make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make
> rule.
> 
> Can we get rid of this one way or the other?

I have tried before - no luck.
This one happens due to a $(Q)$(MAKE) used as part of a $(if
construct in the top-level Makefile.
See around line 335 - 345.
It requires more than trivial changes to get rid of this one.

	Sam
