Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273203AbRJJBav>; Tue, 9 Oct 2001 21:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273108AbRJJBaf>; Tue, 9 Oct 2001 21:30:35 -0400
Received: from maile.telia.com ([194.22.190.16]:35266 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S272773AbRJJBa1>;
	Tue, 9 Oct 2001 21:30:27 -0400
Message-ID: <3BC3A49B.15D1997C@canit.se>
Date: Wed, 10 Oct 2001 03:30:03 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: kernel size
In-Reply-To: <Pine.LNX.3.95.1011009114946.4152A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> On Tue, 9 Oct 2001, Horst von Brand wrote:
>
> > "Richard B. Johnson" <root@chaos.analogic.com> said:
> > > On Tue, 9 Oct 2001, Ingo Oeser wrote:
> >
> > [...]
> >
> > > > strip -R .ident -R .comment -R .note
> > > >
> > > > is your friend.
> >
> > [...]
> >
> > > Yes! Wonderful...
> > > -rwxr-xr-x   1 root     root      1571516 Oct  9 10:50 vmlinux
> > > -rwxr-xr-x   1 root     root      1590692 Oct  1 13:26 vmlinux.OLD
> > >
> > > That got rid of some cruft.
> >
> > Yep. A WHOOPing 1.2% of the total. BTW, is this stuff ever being loaded
> > into RAM with the executable kernel, discarded on boot, or what?
> >
>
> Yes. It shows in /proc/kcore. Just wasted. It does mean something
> on an embedded system.
>
> It just __might__ mean that I can use a later kernel than 2.4.1
> (they grow, you know). I'm mucking with things now.
>

You do know that kcore shows all memory not just what was compiled into the
kernel. even usless old file cache so it's not so easy to se how much space
the strings use of real memory.

Test with creating a file with a string your not likly to have anywhere else.

num=1 ;while ((1)) ; do echo "xenomorph $num"; num=$(($num+1)) ; done >1.txt

strings /proc/kcore | grep xenomorph


