Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319314AbSIFS1U>; Fri, 6 Sep 2002 14:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319315AbSIFS1U>; Fri, 6 Sep 2002 14:27:20 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:47887 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S319314AbSIFS1T>; Fri, 6 Sep 2002 14:27:19 -0400
Date: Fri, 6 Sep 2002 19:31:57 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Message-ID: <20020906183157.GA44177@compsoc.man.ac.uk>
References: <3D78C9BD.5080905@us.ibm.com> <53430559.1031304588@[10.10.2.3]> <3D78E7A5.7050306@us.ibm.com> <20020906202646.A2185@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020906202646.A2185@wotan.suse.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 08:26:46PM +0200, Andi Kleen wrote:

> > c0216ecc 257768   11.4219     inet_bind
> 
> The profile looks bogus. The NIC driver is nowhere in sight. Normally
> its mmap IO for interrupts and device registers should show. I would
> double check it (e.g. with normal profile) 

The system summary shows :

58181      1.8458 0.0000 /lib/modules/2.4.18+O1/kernel/drivers/net/acenic.o

so it won't show up in the monolithic kernel profile. You can probably
get a combined comparison with

op_time -dnl | grep -e 'vmlinux|acenic'

regards
john

-- 
 "Are you willing to go out there and save the lives of our children, even if it means losing your own life ?
 Yes I am.
 I believe you, Jeru... you're ready."
