Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbUCSTBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 14:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUCSTBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 14:01:35 -0500
Received: from smtp02.web.de ([217.72.192.151]:29196 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263083AbUCSTBd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 14:01:33 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Date: Fri, 19 Mar 2004 20:01:11 +0100
User-Agent: KMail/1.5.4
Cc: Philippe Elie <phil.el@wanadoo.fr>, Andrew Morton <akpm@osdl.org>,
       Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
References: <200403090014.03282.thomas.schlichter@web.de> <200403091208.20556.thomas.schlichter@web.de> <Pine.LNX.4.55.0403171734090.14525@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0403171734090.14525@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403192001.13129.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 17. März 2004 17:51 schrieb Maciej W. Rozycki:

~~ snip ~~

>  You need timer_ack set to one when either:
>
> 1. you use the I/O APIC NMI watchdog and you have a discrete APIC chip
> (i.e. the 82489DX),
>
> or:
>
> 2. the timer interrupt (IRQ 0) goes through one of the APICs (whatever
> way; we check three variations) and the TSC is non-functional (absent or
> disabled).
>
> Since you have an integrated APIC and you use the TSC, you may have
> timer_ack set to zero.  That saves a few (possibly slow) I/O accesses and
> works around problems that may arise due 8259A clone (in)compatibility or
> bugs in SMM firmware.
>
>   Maciej

Well, my timer interrupt goes through the IO-APIC but I do have a functional 
TSC. Nevertheless my system requires timer_ack to be set... If it isn't, my 
CPU does not utilize its C2 state...

  Thomas

