Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbUCCFJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbUCCFJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:09:05 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:48365 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262395AbUCCFI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:08:58 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: kgdb support in vanilla 2.6.2
Date: Wed, 3 Mar 2004 10:38:39 +0530
User-Agent: KMail/1.5
Cc: ak@suse.de, pavel@ucw.cz, linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <20040302132751.255b9807.akpm@osdl.org> <40451E50.4080806@mvista.com>
In-Reply-To: <40451E50.4080806@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403031038.39339.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Mar 2004 5:22 am, George Anzinger wrote:
> Andrew Morton wrote:
> > George Anzinger <george@mvista.com> wrote:
> >> Often it is not clear just why we are in the stub, given that
> >>we trap such things as kernel page faults, NMI watchdog, BUG macros and
> >> such.
> >
> > Yes, that can be confusing.  A little printk on the console prior to
> > entering the debugger would be nice.
>
> That assumes that one can do a printk and not run into a lock.  Far better
> IMNSHO is to provide a simple way to get it from gdb.  One can then even
> provide a gdb macro to print the relevant source line and its surrounds.  I
> my lighter moments I call this the comefrom macro :)  In my kgdb it would
> look like:
>
> l * kgdb_info.called_from

How about echoing "Waiting for gdb connection" stright into the serial line 
without any encoding? Since gdb won't be connected to the other end, and many 
a times a minicom could be running at the other end, it'll give a user an 
indication of kgdb being ready.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

