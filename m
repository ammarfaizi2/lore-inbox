Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272298AbRHXSsk>; Fri, 24 Aug 2001 14:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272299AbRHXSsb>; Fri, 24 Aug 2001 14:48:31 -0400
Received: from dryline-fw.yyz.somanetworks.com ([216.126.67.45]:36957 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S272298AbRHXSs1>; Fri, 24 Aug 2001 14:48:27 -0400
Date: Fri, 24 Aug 2001 14:48:42 -0400
From: Mark Frazer <mark@somanetworks.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Anwar P <anwarp@mail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: What version of the kernel fixes these VM issues?
Message-ID: <20010824144842.A9414@somanetworks.com>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Anwar P <anwarp@mail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108241354520.25240-100000@xanadu.home> <Pine.LNX.4.33.0108241425190.25240-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108241425190.25240-100000@xanadu.home>; from nico@cam.org on Fri, Aug 24, 2001 at 02:25:55PM -0400
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas.  You should run vmstat and watch the paging activity.
We've seen our ARM boards get driven to a standstill by paging when
they run out of RAM.  We have no swap either.  To make things worse,
our flash loads are compressed, so we burn all our CPU in decompression
when paging back in.  If you have no swap, the only thing that can be
booted out are executable pages.

Kernel folk:  do /proc/sys/vm/{pagecache,buffermem} still do anything?
Could Nicolas still limit the pagecache using these?

cheers
-mark

Nicolas Pitre <nico@cam.org> [01/08/24 14:38]:
> 
> 
> On Fri, 24 Aug 2001, Nicolas Pitre wrote:
> 
> > I have a totally different setup but I can reproduce the same behavior on
> > the system I have here:
> >
> > ARM board with 32 MB RAM, no flash, NFS root.
> 
> Sorry I meant no swap.
> 
> 
> Nicolas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
