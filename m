Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUCDFHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUCDFHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:07:21 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:51141 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261452AbUCDFHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:07:19 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andi Kleen <ak@suse.de>, George Anzinger <george@mvista.com>
Subject: Re: kgdb support in vanilla 2.6.2
Date: Thu, 4 Mar 2004 10:36:58 +0530
User-Agent: KMail/1.5
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com, trini@kernel.crashing.org
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <40467BC3.7030708@mvista.com> <20040304015056.4d2cc3ee.ak@suse.de>
In-Reply-To: <20040304015056.4d2cc3ee.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403041036.58827.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Mar 2004 6:20 am, Andi Kleen wrote:
> On Wed, 03 Mar 2004 16:43:47 -0800
>
> George Anzinger <george@mvista.com> wrote:
> > Andi Kleen wrote:
> > > On Tue, Mar 02, 2004 at 01:27:51PM -0800, Andrew Morton wrote:
> > >>George Anzinger <george@mvista.com> wrote:
> > >>> Often it is not clear just why we are in the stub, given that
> > >>>we trap such things as kernel page faults, NMI watchdog, BUG macros
> > >>> and such.
> > >>
> > >>Yes, that can be confusing.  A little printk on the console prior to
> > >>entering the debugger would be nice.
> > >
> > > What I did for kdb and panic some time ago was to flash the keyboard
> > > lights. If you use a unique frequency (different from kdb
> > > and from panic) it works quite nicely.

Flashing keyboard lights is far simpler compared to a printk. Printk is too 
heavy. Once a system is unstable, it's more important to run into kgdb code 
asap. Calling printk and co may be too much.

> >
> > Assuming a key board and a clear (no spin locks) path to it.  Still it
> > only says
>
> I think it's reasonable to just write to the keyboard without any locking.
> The keyboard driver will recover.

Flashing keyboard lights is easy on x86 and x86_64 platforms. Is that easy on 
ppc workstations/servers? Embedded boards don't have keyboards.

>
> > we are in kgdb, now why.
>
> The big advantage is that it works even when you are in X (like most
> people) printks are often not visible.

Yep.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

