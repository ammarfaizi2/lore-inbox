Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSJWBrt>; Tue, 22 Oct 2002 21:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSJWBrt>; Tue, 22 Oct 2002 21:47:49 -0400
Received: from [195.223.140.120] ([195.223.140.120]:36651 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262662AbSJWBrs>; Tue, 22 Oct 2002 21:47:48 -0400
Date: Wed, 23 Oct 2002 03:51:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, ak@muc.de,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       george anzinger <george@mvista.com>, Jeff Dike <jdike@karaya.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [RFC] linux-2.5.44_vsyscall-proc_A0
Message-ID: <20021023015157.GI11242@dualathlon.random>
References: <1035336629.954.90.camel@cog> <1035336772.954.95.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035336772.954.95.camel@cog>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 06:32:51PM -0700, john stultz wrote:
> All
> 	Well, just to fan the flames a bit, here is a patch (applies on top of
> vsyscall_A1)that adds a /proc/vsyscall interface which gives the address
> of the vsyscall page if its mapped in. This could be then used to help
> the UML folks virtualize things, as well as give a cross platform
> interface that could be used. There's probably a better place in /proc
> for this, but this is just something to start from. 
> 	
> Let me know your thoughts.

there is no point for this last patch. The vsyscall_ptr is the vsyscall
number.

This is equivalent to a proc that shows the syscall number of
sys_gettimeofday, useless, cat on unistd.h and vsyscall.h will avoid a
waste of kernel mem.

the uml folks need to replace the vsyscalls, they just know their
address, like they just know the syscall number of sys_gettimeofday.

Andrea
