Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUIMAqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUIMAqW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 20:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUIMAp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 20:45:57 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:54706 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264500AbUIMApv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 20:45:51 -0400
Date: Sun, 12 Sep 2004 20:45:18 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
cc: Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>
Message-ID: <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet>  <1094853588.18235.12.camel@localhost.localdomain>
  <Pine.LNX.4.58.0409110137590.26651@skynet>  <1094912726.21157.52.camel@localhost.localdomain>
  <Pine.LNX.4.58.0409122319550.20080@skynet> <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-275043848-1095036318=:9611"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-275043848-1095036318=:9611
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Sun, 12 Sep 2004, Michel [ISO-8859-1] D=E4nzer wrote:

> On Sun, 2004-09-12 at 23:42 +0100, Dave Airlie wrote:
>>
>> I think yourself and Linus's ideas for a locking scheme look good, I als=
o
>> know they won't please Jon too much as he can see where the potential
>> ineffecienes with saving/restore card state on driver swap are, especail=
ly
>> on running fbcon and X on a dual-head card with different users.
>
> Frankly, I don't understand the fuss about that. When you run a 3D
> client on X today, 3D client and X server share the accelerator with
> this scheme, and as imperfect as it is, it seems to do a pretty good job
> in my experience.

Not that good - try dragging something while a DVD video is playing.

But, I don't understand what the fuss is about either. What's wrong with=20
putting PLL setting code inside DRM driver and letting it be the client of=
=20
fbcon ? And the transition problems could be well solved by leaving the=20
existing fbcon in for the time being, it is not like the kernel does not=20
have duplicate drivers.

                      best

                        Vladimir Dergachev

>
>
> --=20
> Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI devel=
oper
> Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenze=
r
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>
---1463811584-275043848-1095036318=:9611--
