Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292846AbSCOQKl>; Fri, 15 Mar 2002 11:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSCOQKb>; Fri, 15 Mar 2002 11:10:31 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:59895 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292846AbSCOQKQ>; Fri, 15 Mar 2002 11:10:16 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020315080408.D11940@work.bitmover.com> 
In-Reply-To: <20020315080408.D11940@work.bitmover.com>  <3C90E994.2030702@candelatech.com> <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva> <3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com> <3C90E994.2030702@candelatech.com> <2865.1016190641@redhat.com> 
To: Larry McVoy <lm@bitmover.com>
Cc: Ben Greear <greearb@candelatech.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Mar 2002 16:10:06 +0000
Message-ID: <14776.1016208606@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lm@bitmover.com said:
>  Has anyone done this and made it work?  It would save a lot of disk
> space and performance if someone were to so.

I fixed up the dependencies on stuff in scripts/ and all the Config.in 
files, so I could take a clean tree and run make config. 

The kbuild-2.4 make dep didn't find any C files so didn't do much -
kbuild-2.5 would be a more useful base for such a game. I ignored the lack
of dependencies and went on to 'make vmlinux', at which point it started
trying to include header files from /usr/include/linux because they weren't
present in the kernel tree and we don't build with -nostdinc.

Extracting the information about what include files we need to get from 
SCCS is a difficult problem. 

--
dwmw2


