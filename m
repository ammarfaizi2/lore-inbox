Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSCOLNF>; Fri, 15 Mar 2002 06:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSCOLL5>; Fri, 15 Mar 2002 06:11:57 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:11510 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S290277AbSCOLKq>; Fri, 15 Mar 2002 06:10:46 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3C90E994.2030702@candelatech.com> 
In-Reply-To: <3C90E994.2030702@candelatech.com>  <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva> <3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com> 
To: Ben Greear <greearb@candelatech.com>
Cc: Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Mar 2002 11:10:41 +0000
Message-ID: <2865.1016190641@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


greearb@candelatech.com said:
>  I did a clone with this.  However, I see no files, only directories.
> The files do seem to be in the SCCS directories, but I don't know how
> to make them appear in their normal place. 

Type 'make config'. Make is clever enough to get the Makefile from SCCS for 
you. Add the missing dependencies to the Makefile so that make will fetch 
stuff like scripts/Configure before trying to run it, etc. 

Making it get all the Config.in files by parsing arch/$(ARCH)/config.in is
a fairly trivial task... but you do need to explicitly check out all the 
include directories, because we don't know how to deal with that yet. With 
kbuild-2.4, make dep won't work very well, but kbuild-2.5 ought to be OK 
with everything but the include files, I think.

Or you could just check it all out beforehand with bk -r co.

--
dwmw2


