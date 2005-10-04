Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVJDHGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVJDHGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 03:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVJDHGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 03:06:11 -0400
Received: from web35504.mail.mud.yahoo.com ([66.163.179.128]:22457 "HELO
	web35504.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932446AbVJDHGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 03:06:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=km/O6u5LTfqCszVgdiKSlOEJ6OpmjNtNmE6PPYIZP0YY5azCdxIpXkNSGgN6t3+ir2Ts+WtmiucxWY2EAszvG2vuGe4SGKnMNyOjDiWiOOB419klQDF2Xgo0XG6dJF6JuZpArV92gBCX5qswIOID5lVXPWbY+afBx+QRKmgA5Hw=  ;
Message-ID: <20051004070609.18835.qmail@web35504.mail.mud.yahoo.com>
Date: Tue, 4 Oct 2005 00:06:09 -0700 (PDT)
From: Dan C Marinescu <dan_c_marinescu@yahoo.com>
Subject: Re: The price of SELinux (CPU)
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43421F46.8030202@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the benchmark "results" _look_ like being authored by
some qa engineers... or sysadmins or something...

*** only a deep/intimate knowledge of kernel and fs
and acl implementation details and many other areas
could suggest a credible conclusion (most likely
without even needing any "profiling" at all... on pure
theoretical basis, mostly because you would know what
goes where and when and how and why and how much it
adds here and there, etc, etc, etc)

and i personally have a strong doubt that if the cpu
activity was statistically increased with 7% for the
very same elementary I/O, linus would have accepted
this degradation... my $0.02... :-)

   d

--- John Richard Moser <nigelenki@comcast.net> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I'm not an expert in this kind of stuff.  I wonder
> where the numbers
> come from; i.e. is 7% from policy?  A O(1) policy
> lookup would be immune
> to big policies; a O(n) would probably not have that
> much impact from a
> typical policy lookup.  Still perhaps interpreting
> the policy is a chore
> in itself, which still says bigger policy means
> bigger hit.  Or is 7%
> constant?
> 
> I don't know what the frame of reference is or was. 
> I'm sure with
> selinux with no policy it's rather 0ish; what I
> don't know is what I'm
> supposed to be looking at for benchmarking.  Just
> randomly turning
> SELinux on and off and looking might give me an
> invalid measure.
> 
> Dan C Marinescu wrote:
> > i suggested you to disable selinux in order to
> have
> > something to compare to... (engineers compare,
> > measure, instead of believing in rummors...)
> > 
> >    d
> > 
> > --- John Richard Moser <nigelenki@comcast.net>
> wrote:
> > 
> > 
> > I'm not an abortionist; if I hear something has an
> > ugly side, I try to
> > find out if it can be fixed, and if the trade-off
> is
> > worth getting rid
> > of it.  SELinux and LSM are quite useful you know;
> > the overhead is
> > probably not even that significant on the desktop
> to
> > gamers (although if
> > you TELL them about it they'll piss themselves),
> > from a practical
> > viewpoint considering their excessive hardware.
> > 
> > Dan C Marinescu wrote:
> > 
> >>try selinux=0, _if u feel that way :-)
> > 
> >>about big o:
> > 
> > 
> > 
> >>
>
http://www.maththinking.com/boat/compsciBooksIndex.html
> > 
> >>   daniel
> > 
> > 
> > 
> >>--- John Richard Moser <nigelenki@comcast.net>
> > 
> > wrote:
> > 
> > 
> >>I've heard that SELinux has produced benchmarks
> > 
> > such
> > 
> >>as 7% increased CPU
> >>load.  Is this true and current?  Is it dependent
> > 
> > on
> > 
> >>policy?  What is
> >>the policy lookup complexity ( O(1), O(n),
> >>O(nlogn)...)?  Are there
> >>other places where a bottleneck may exist aside
> > 
> > from
> > 
> >>gruffing with the
> >>policy?  Isn't the policy actually in xattrs so
> > 
> > it's
> > 
> >>O(1)?  Where else
> >>would an overhead that big come from aside from a
> >>lookup in a table?
> > 
> >>....
> > 
> >>Why is the sky blue?  Why do you have a mustach? 
> >>Why doesn't mommy have
> >>one?  Does she shave it?
> > 
> >>At any rate, my personal end goal is a secure
> >>high-performance operating
> >>system, as user friendly as Ubuntu, Mandriva, or
> >>Win----.  To this end,
> >>I'm (still; a lot of you have seen me before)
> >>evaluating the performance
> >>hit of various user and kernel security
> > 
> > enhancements
> > 
> >>like PaX,
> >>ProPolice, various OpenWall/GrSecurity niceness
> > 
> > that
> > 
> >>needs to be divided
> >>out, and of course LSM/SELinux.  Also wondering
> >>about that PHKMalloc
> >>thing on openbsd; is it really all that, is it
> > 
> > junk,
> > 
> >>how's it compare to
> >>the recent ptmalloc work, and can it run on Linux
> >>for direct benching .
> >>. . but that's off topic.
> > 
> >>--
> >>All content of all messages exchanged herein are
> >>left in the
> >>Public Domain, unless otherwise explicitly stated.
> > 
> >>    Creative brains are a valuable, limited
> >>resource. They shouldn't be
> >>    wasted on re-inventing the wheel when there
> > 
> > are
> > 
> >>so many fascinating
> >>    new problems waiting out there.
> > 
> > 
> > --
> > 
> >>Eric Steven Raymond
> > 
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> >>__________________________________ 
> >>Yahoo! Mail - PC Magazine Editors' Choice 2005 
> >>http://mail.yahoo.com
> > 
> > 
> > --
> > All content of all messages exchanged herein are
> > left in the
> > Public Domain, unless otherwise explicitly stated.
> > 
> >     Creative brains are a valuable, limited
> > resource. They shouldn't be
> >     wasted on re-inventing the wheel when there
> are
> > so many fascinating
> >     new problems waiting out there.
> >                                                 
> --
> > Eric Steven Raymond
> - -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> > __________________________________ 
> > Yahoo! Mail - PC Magazine Editors' Choice 2005 
> > http://mail.yahoo.com
> 
> 
> - --
> All content of all messages exchanged herein are
> left in the
> Public Domain, unless otherwise explicitly stated.
> 
>     Creative brains are a valuable, limited
> resource. They shouldn't be
>     wasted on re-inventing the wheel when there are
> so many fascinating
>     new problems waiting out there.
>                                                  --
> Eric Steven Raymond
> -----BEGIN PGP SIGNATURE-----
> 
=== message truncated ===



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
