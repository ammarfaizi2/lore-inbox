Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUGBSQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUGBSQC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUGBSQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:16:01 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23494 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264858AbUGBSOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:14:23 -0400
Date: Fri, 2 Jul 2004 13:13:47 -0500
From: linas@austin.ibm.com
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: nfont@austin.ibm.com, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
Message-ID: <20040702131347.V21634@forte.austin.ibm.com>
References: <20040629191046.Q21634@forte.austin.ibm.com> <16610.39955.554139.858593@cargo.ozlabs.ibm.com> <20040701160614.I21634@forte.austin.ibm.com> <16613.15510.325099.273419@cargo.ozlabs.ibm.com> <3EC84E0C-CC32-11D8-BDBD-000A95A0560C@us.ibm.com> <40E58AE9.6050009@austin.ibm.com> <1088789345.26946.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1088789345.26946.9.camel@localhost>; from hollisb@us.ibm.com on Fri, Jul 02, 2004 at 12:29:08PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 12:29:08PM -0500, Hollis Blanchard wrote:
> On Fri, 2004-07-02 at 11:18, Nathan Fontenot wrote:
> > > I asked about this before, and was told that there is no way to
> > > determine the severity of an event without doing full parsing of the
> > > binary data. I'd be thrilled to be wrong...
> > 
> > Gettting the severity of an RTAS event is possible, and not too 
> > difficult.  Check out asm-ppc64/rtas.h for a definition of the
> > RTAS event header (struct rtas_error_log).  All RTAS events have the 
> > same initial header containing the severity of the event.
> 
> Great! Of course that won't help much if we get repeating "important"
> events that aren't even interesting much less important, but it's worth
> trying to printk only the important ones and leave the rest to netlink.

OK,

I'd like to wait until some of the current patches get in, so as to 
avoid a case of patch-versionitis.

I mis-spoke earlier about who the intendend consumers of the printk'ed 
messages are; rtasd already implements its own kernl-to-user interface
via the /proc interface.  Yes, everything in /proc/ppc64 is prolly 
deprecated, but lets put this off till later.

--linas
