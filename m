Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266763AbUHSUxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266763AbUHSUxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUHSUxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:53:08 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:18379 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266763AbUHSUxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:53:04 -0400
Date: Thu, 19 Aug 2004 22:53:01 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org,
       Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: GNU make alleged of "bug" (was: PATCH: cdrecord: avoiding scsi device numbering for ide devices)
Message-ID: <20040819205301.GA12251@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Joerg Schilling <schilling@fokus.fraunhofer.de>
References: <200408191600.i7JG0Sq25765@tag.witbe.net> <200408191341.07380.gene.heskett@verizon.net> <20040819194724.GA10515@merlin.emma.line.org> <20040819220553.GC7440@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040819220553.GC7440@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Sam Ravnborg wrote:

> On Thu, Aug 19, 2004 at 09:47:24PM +0200, Matthias Andree wrote:
> > # BEGIN Makefile
> > all:    hello
> > hello.d:
> >         makedepend -f- hello.c >$@
> > include hello.d
> > # END Makefile
> > 
> > You'll get at "make" time:
> > 
> > Makefile:5: hello.d: No such file or directory
> > makedepend -f- hello.c >hello.d
> > cc   hello.o   -o hello
> > 
> > and a working hello program.
> 
> Using:
> -include hello.d
> will result in a silent make.

Indeed it will. However, Solaris' /usr/ccs/bin/make doesn't understand
the "-include" form:

make: Fatal error in reader: Makefile, line 5: Unexpected end of line seen

include without leading "-" is fine. BSD make doesn't understand either
form.

Jörg, how about Sam's suggestion? It seems compatible with smake.

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
