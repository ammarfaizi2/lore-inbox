Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290216AbSBKTYT>; Mon, 11 Feb 2002 14:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290218AbSBKTWZ>; Mon, 11 Feb 2002 14:22:25 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:1975 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290216AbSBKTV5>; Mon, 11 Feb 2002 14:21:57 -0500
Date: Mon, 11 Feb 2002 14:21:56 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: John Weber <weber@nyc.rr.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.4 Sound Driver Problem
Message-ID: <20020211142156.A2665@devserv.devel.redhat.com>
In-Reply-To: <E16aKwN-0007Ro-00@the-village.bc.nu> <3C6809C2.1030808@nyc.rr.com> <20020211132725.A18726@devserv.devel.redhat.com> <3C6816EC.2040406@nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6816EC.2040406@nyc.rr.com>; from weber@nyc.rr.com on Mon, Feb 11, 2002 at 02:09:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 11 Feb 2002 14:09:32 -0500
> From: John Weber <weber@nyc.rr.com>

> I enable ymfpci, and I have to compile and link dmabuf.c which leads to 
> the problem (the only other sound options enabled are 
> CONFIG_SOUND_GAMEPORT and CONFIG_SOUND_OSS).

> By the way, I don't use modules so this problem results in a link error. 
>    I guess I could use modules if this would rectify the problem.

Try to do this. Open drivers/sound/Config.in, and find YMFPCI
tristate, then delete $CONFIG_SOUND_OSS from that line.
Edit .config, and remove CONFIG_SOUND_OSS. Rerun make oldconfig,
when prompted for CONFIG_SOUND_OSS, say N. This should work.

I use monolithic kernels on 2.4, but on 2.5 it is officially
discouraged, so I gave up on it.

I do not see ANYTHING in 2.5.4 Makefiles that depended on
CONFIG_SOUND_GAMEPORT. This option only works to restric
some configurations choices, but it does not control any
compilations. Seems like a deadwood to me. Just kill it too.

-- Pete
