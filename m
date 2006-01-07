Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752499AbWAGCSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbWAGCSA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 21:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbWAGCSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 21:18:00 -0500
Received: from mx1.suse.de ([195.135.220.2]:33683 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752499AbWAGCR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 21:17:59 -0500
From: Andi Kleen <ak@suse.de>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
Date: Sat, 7 Jan 2006 02:11:02 +0100
User-Agent: KMail/1.8.2
Cc: Sam Ravnborg <sam@ravnborg.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <p73k6dcykar.fsf@verdi.suse.de> <20060107002006.GA23554@waste.org>
In-Reply-To: <20060107002006.GA23554@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601070211.03585.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 01:20, Matt Mackall wrote:
> On Sat, Jan 07, 2006 at 01:05:16AM +0100, Andi Kleen wrote:
> > And gcc is really picky about type compatibility between source files
> > with program-at-a-time.  If any types of the same symbols are
> > incompatible even in minor ways you get an ICE. That's technically
> > illegal, but tends to happen often in practice (e.g. when people
> > use extern) It might end up being quite a lot of work to clean this up.
> 
> If it gave a useful error message rather than an ICE, that'd be a
> feature.

Well you can use a lint program to catch these things. Pretty much
all lints do whole program analysis for types. Perhaps it would
be a good idea to adopt one for the kernel. The best one is unfortunately
not free.

Or just never put an extern into any .c file and set some linker
options that make sure that double definitions without extern
error out (not sure that's possible, but it might be) 

-Andi
