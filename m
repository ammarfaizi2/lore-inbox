Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbTGEXyy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 19:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266562AbTGEXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 19:54:54 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:52946 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S266561AbTGEXyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 19:54:53 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.5.74-mm1
Date: Sun, 6 Jul 2003 02:10:32 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <200307051728.12891.phillips@arcor.de> <20030705121416.62afd279.akpm@osdl.org>
In-Reply-To: <20030705121416.62afd279.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307060210.32021.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 July 2003 21:14, Andrew Morton wrote:
> Daniel Phillips <phillips@arcor.de> wrote:
> > Kgdb is no help in
> > diagnosing, as the kgdb stub also goes comatose, or at least the serial
> > link does.  No lockups have occurred so far when I was not interacting
> > with the system via the keyboard or mouse.  Suggestions?
>
> Enable IO APIC, Local APIC, nmi watchdog.  Use serial console, see if you
> can get a sysrq trace out of it.  That's `^A F T' in minicom.

OK, tried that.  Still very dead.

> I mean, it _has_ to be either stuck with interrupts on, or stuck with them
> off.

Interesting data: it always hangs on the 4th iteration of Ctrl-Alt-F7, 
Ctrl-Alt-F2.  This smells like a bios stack overflow.  I think I'd better go 
poke at the vendor at this point, no?

I do feel Linux is exonerated, but then this just shows why we need to keep on 
moving, right on into the bios.

Regards,

Daniel



