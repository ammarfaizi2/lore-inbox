Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbTIVVk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTIVVk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:40:29 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:59522 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262791AbTIVVkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:40:22 -0400
Date: Mon, 22 Sep 2003 14:40:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: 2.6.0-test5 - powermac compile problem "incorrect section attributes for .plt"
Message-ID: <20030922214020.GR7443@ip68-0-152-218.tc.ph.cox.net>
References: <20030922162156.GI7443@ip68-0-152-218.tc.ph.cox.net> <200309222108.h8ML8Tp22032@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309222108.h8ML8Tp22032@mail.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 02:08:29PM -0700, Cliff White wrote:

> > On Fri, Sep 19, 2003 at 03:08:32PM -0700, Cliff White wrote:
> > 
> > > System is an iBook2,
> > > distro is Debian unstable
> > > kernel is 2.6.0-test5 or current from
> > > bk://ppc.bkbits.net/linuxppc-2.5
> > > 
> > > gcc version 3.3.2 20030908 (Debian prerelease)
> > > 
> > > When compiling modules, i get this warning, repeatedly:
> > >  CC [M]  sound/ppc/pmac.o
> > > {standard input}: Assembler messages:
> > > {standard input}:3: Warning: setting incorrect section attributes for .plt
> > > 
> > > Then, this failure:
> > > 
> > >   AS      arch/ppc/boot/common//util.o
> > > arch/ppc/boot/common/util.S: Assembler messages:
> > > arch/ppc/boot/common/util.S:220: Warning: setting incorrect section attributes 
> > > for .relocate_code
> > > arch/ppc/boot/common//util.o: File truncated
> > > arch/ppc/boot/common/util.S:281: FATAL: Can't write 
> > > arch/ppc/boot/common//util.o: File truncated
> > > make[2]: *** [arch/ppc/boot/common//util.o] Error 1
> > > make[1]: *** [arch/ppc/boot/common/] Error 2
> > > 
> > > Suggestions appreciated.
> > 
> > I suspect this is a binutils bug.  But can you try the following?  We
> > shouldn't need a '.previous' here, as it is the end of the file anyhow.
> > 
> I believe this is a binutils bug. 

It is.  From http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=211668,
http://sources.redhat.com/ml/binutils/2003-09/msg00381.html

-- 
Tom Rini
http://gate.crashing.org/~trini/
