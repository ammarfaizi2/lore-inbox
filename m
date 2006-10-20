Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992738AbWJTWbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992738AbWJTWbX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992887AbWJTWbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:31:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992738AbWJTWbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:31:22 -0400
Date: Fri, 20 Oct 2006 15:29:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Bryce Harrington <bryce@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Peschke <mp3@de.ibm.com>
Subject: Re: 2.6.19-rc2-mm2 not building on ia64
Message-Id: <20061020152939.1af272b4.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610210007020.29022@twin.jikos.cz>
References: <20061020205742.GU10386@osdl.org>
	<Pine.LNX.4.64.0610210007020.29022@twin.jikos.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2006 00:14:34 +0200 (CEST)
Jiri Kosina <jikos@jikos.cz> wrote:

> On Fri, 20 Oct 2006, Bryce Harrington wrote:
> 
> > We're seeing the following error building the 2.6.19-rc2-mm2 kernel on
> > ia64 (it builds ok on x86_64).  2.6.19-rc2-git4 builds ok.
> >   CC [M]  drivers/acpi/processor_throttling.o
> > arch/ia64/sn/kernel/setup.c: In function `sn_setup':
> > arch/ia64/sn/kernel/setup.c:470: error: `ia64_timestamp_clock' undeclared (first use in this function)
> > arch/ia64/sn/kernel/setup.c:470: error: (Each undeclared identifier is reported only once
> > arch/ia64/sn/kernel/setup.c:470: error: for each function it appears in.)
> >   CC      fs/ext2/namei.o
> > make[2]: *** [arch/ia64/sn/kernel/setup.o] Error 1
> > make[1]: *** [arch/ia64/sn/kernel] Error 2
> > make: *** [arch/ia64/sn] Error 2
> > make: *** Waiting for unfinished jobs....
> 
> (added relevant CCs)
> 
> This is caused by 
> statistics-infrastructure-make-printk_clock-a-generic-kernel-wide-nsec-resolution.patch
> 
> I wonder how this could ever compile :) 

grr.  How many times do we have to tell how many people to not put extern
declarations in C files?  This build error is a direct consequence of that
absolutely utterly basic programming mistake.

> Andrew, could you please apply this trivial on top of the original one?

If I had the energy I'd fix it for real, but I don't so I won't.  Thanks.

