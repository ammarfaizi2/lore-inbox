Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSKFQL2>; Wed, 6 Nov 2002 11:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265800AbSKFQL2>; Wed, 6 Nov 2002 11:11:28 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:28041 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265798AbSKFQLX>; Wed, 6 Nov 2002 11:11:23 -0500
Date: Wed, 6 Nov 2002 11:18:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Kswapd madness in 2.4 kernels
In-Reply-To: <20021106111149.GC3823@x30.school.suse.de>
Message-ID: <Pine.LNX.4.44L.0211061118100.22953-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Nov 2002, Andrea Arcangeli wrote:

> On Tue, Nov 05, 2002 at 02:13:00PM -0800, James Cleverdon wrote:
> > Status report:
> >
> > Due to dependencies, I didn't try the two recommended patches alone.  I ran
> > Andrea's 2.4.20-pre10aa1 kernel on the test load for one week.  Low memory
> > was conserved and kswapd never went out of control.  Presumably,
> > 05_vm_16_active_free_zone_bhs-1 did the job for buffers, and the inode patch
> > continued to work.
>
> yes, for stability the related-bh patch is known to be more than enough
> and this is a nice confirmation. I would also like to integrated some
> bit of andrew's nuke-buffer patch for performance reasons (to maximize
> the free memory utilization), not for stability. For stability teaching
> the VM about the problem is the right fix IMHO, good to have regardless
> in case for some reason the bh cannot be nucked if we can't take a lock
> or similar. But the bit that drops the bhs after reads may improve
> memory utilization when there is no memory pressure at all. The part I
> wouldn't merge in 2.4 from the Andrew's patch is the drop after writes,
> that has the potential of slowing down rewrite. I'm not saying it will
> slow down the rewrite performance, but there is definitely the
> potential. My fix instead has no way to affect read/writes w/o memory
> pressure compared to mainline (i.e. in a <1G machine).
>
> > Are there any plans on getting these into 2.4.21?

I will look closely at -aa during 2.4.21-pre stage, yes.

Andrea, please bug me on that.

