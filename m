Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265585AbUABN5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265579AbUABN5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:57:47 -0500
Received: from stine.vestdata.no ([195.204.68.10]:3482 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id S265580AbUABN51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:57:27 -0500
Date: Fri, 2 Jan 2004 14:57:13 +0100
From: Ragnar =?iso-8859-15?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040102135713.GA9935@vestdata.no>
References: <3FF56B1C.1040308@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FF56B1C.1040308@conet.cz>
User-Agent: Mutt/1.5.2i
X-Zet.no-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 01:59:08PM +0100, Libor Vanek wrote:
> Hi,
> I'm writing some project which needs to hijack some syscalls in VFS 
> layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are 
> some very nasty ways of doing it - see 
> http://mail.nl.linux.org/kernelnewbies/2002-12/msg00266.html )
> 
> Also I've found out that Linus stated that intercepting syscalls is "bad 
> thing" (load module a, load module b, unload module b => crash) but I 
> think that there are some very good reasons (and ways) to do it (see 
> http://syscalltrack.sourceforge.net ). My main reason to do it is that I 
> want my GPLed module to be able to modify some VFS syscalls without 
> patching and recompiling whole kernel and rebooting the machine.

As part of the openxdsm-project we wrote an syscall-intercept module
that "solves" the (load module a, load module b, unload module b =>
crash) part by providing a common infrastructure for intercepting
syscalls.

It's available at:
http://cvs.sourceforge.net/viewcvs.py/openxdsm/openxdsm/eventmodule/module/events.c?rev=1.1.1.1&view=auto


-- 
Ragnar Kjørstad
