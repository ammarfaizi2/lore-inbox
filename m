Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbRCWWGg>; Fri, 23 Mar 2001 17:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131474AbRCWWG0>; Fri, 23 Mar 2001 17:06:26 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:20732 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131468AbRCWWGT>; Fri, 23 Mar 2001 17:06:19 -0500
Message-ID: <3ABBC702.AC9C3C92@mvista.com>
Date: Fri, 23 Mar 2001 13:58:26 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jakma <paulj@itg.ie>
CC: Szabolcs Szakacsits <szaka@f-secure.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.33.0103232026310.31380-100000@rossi.itg.ie>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What happens if you just make swap VERY large?  Does the system thrash
it self to a virtual standstill?  Is this a possible answer?  Supposedly
you could then sneak in and blow away the bad guys manually ...

George

Paul Jakma wrote:
> 
> On Fri, 23 Mar 2001, Szabolcs Szakacsits wrote:
> 
> > About the "use resource limits!". Yes, this is one solution. The
> > *expensive* solution (admin time, worse resource utilization, etc).
> 
> traditional user limits have worse resource utilisation? think what
> kind of utilisation a guaranteed allocation system would have. instead
> of 128MB, you'd need maybe a GB of RAM and many many GB of swap for
> most systems.
> 
> some hopefully non-ranting points:
> 
> - setting up limits on a RH system takes 1 minute by editing
> /etc/security/limits.conf.
> 
> - Rik's current oom killer may not do a good job now, but it's
> impossible for it to do a /perfect/ job without implementing
> kernel/esp.c.
> 
> - with limits set you will have:
>  - /possible/ underutilisation on some workloads.
>  - chance of hitting Rik's OOM killer reduced to almost nothing.
> 
> no matter how good or bad Rik's killer is, i'd much rather set limits
> and just about /never/ have it invoked.
> 
> more beancounting will make limits more useful (eg global?) and maybe
> dists can start setting up some kind of limits by default at install
> time based on the RAM installed and whether user selected
> server/workstation/etc.. install.
> 
> Then hopefully we can be a little less concerned about how close Rik
> gets to the impossible task of implementing esp.c.
> 
> >         Szaka
> 
> --paulj
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
