Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280875AbRKBXRR>; Fri, 2 Nov 2001 18:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280874AbRKBXRG>; Fri, 2 Nov 2001 18:17:06 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:28925
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280873AbRKBXQs>; Fri, 2 Nov 2001 18:16:48 -0500
Date: Fri, 2 Nov 2001 15:16:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Weird /proc/meminfo output on 2.4.13-ac5
Message-ID: <20011102151640.B5955@mikef-linux.matchmail.com>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011102132006.A5955@mikef-linux.matchmail.com> <Pine.LNX.4.21.0111022231220.2582-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111022231220.2582-100000@localhost.localdomain>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 10:35:29PM +0000, Hugh Dickins wrote:
> On Fri, 2 Nov 2001, Mike Fedyk wrote:
> > On Fri, Nov 02, 2001 at 07:34:49PM +0000, Petr Vandrovec wrote:
> > > On  2 Nov 01 at 14:10, Andreas Franck wrote:
> > > > $ cat /proc/meminfo
> > > > Cached:       4294741680 kB     <------ This is impossible, i think? :-)
> > > 
> > > I'll upgrade to -ac6 and I'll see.
> > 
> > It won't help.  You'll need a patch that rik has posted a few days ago.
> > 
> > This problem is for 2.4.13, 2.4.13-acX, and 2.4.14pre*.
> 
> I believe that problem only applied to 2.4.13-acX, and arose because
> an inappropriate part of 2.4.13 (relating to blockdev in pagecache) crept
> into 2.4.13-acX.  2.4.13 and 2.4.14-preX should not need Rik's patch.
> 
> Hugh
> 

I am running: $ ud -d
- Uptime for mikef-linux -
Now  : 1 day(s), 03:44:33 running Linux
       2.4.14-pre6+preempt+netdev_random+ext3_0.9.14-2414p5

Check out vmstat:
 0  0  0  49852   3340 180884 4294884956   0   0     1   126  134   249   2
1  97
 1  0  0  49852   3916 180424 4294885152   0   0     0    62  127   254   3
2  95
 0  0  0  49852   3512 180472 4294885496   0   0     0    60  133   267   5
3  91
 0  0  0  49852   4172 179696 4294885660   0   0     0    44  120   228   3
3  94
 0  0  0  49948   4176 178024 4294885640   0  25   120    93  141   362   9
6  85
 0  1  0  49948   3392 174684 4294883668   0  41   249   137  183   415  19
11  70
 0  1  0  49944   3188 176904 4294880964   9  31   293   166  198   450   5
7  89
 0  1  0  50160   4832 177164 4294880100   0   0    76   197  131   395  36
12  52

There you go.  I've also seen a report against 2.4.13 on this list from
Miroslav Zubcic.

Mike
