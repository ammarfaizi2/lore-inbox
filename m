Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVHKRgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVHKRgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVHKRgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:36:10 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:49580 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932255AbVHKRgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:36:09 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1123781187.17269.77.camel@localhost.localdomain>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
	 <1123777184.17269.67.camel@localhost.localdomain>
	 <2cd57c90050811093112a57982@mail.gmail.com>
	 <2cd57c9005081109597b18cc54@mail.gmail.com>
	 <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>
	 <1123781187.17269.77.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 13:33:59 -0400
Message-Id: <1123781639.17269.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 13:26 -0400, Steven Rostedt wrote:

> 288fb seems to use "int 0x80"  and so do all the other system calls that
> I inspected.

I expect that if I had a Gentoo system that I compiled for my machine,
this would be different. But I suspect that Debian still wants to run on
my old Pentium 75MHz laptop.  How would libc know to use sysenter
instead of int 0x80.  It could do a test of the system, but would there
be an if statement for every system call then?   I guess that libc needs
to be compiled either to use it or not. Since there are still several
machines out there that don't have this feature, it would be safer to
not use it.

-- Steve


