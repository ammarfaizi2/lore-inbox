Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261475AbSJIAss>; Tue, 8 Oct 2002 20:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSJIAss>; Tue, 8 Oct 2002 20:48:48 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:8462 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S261475AbSJIAsr>;
	Tue, 8 Oct 2002 20:48:47 -0400
Subject: Re: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021008192512.B26021@ucw.cz>
References: <20020926185717.B27676@ucw.cz>
	<1033080648.593.12.camel@chevrolet> <20020927091040.B1715@ucw.cz>
	<1033127503.589.6.camel@chevrolet> <20021007150052.A1380@ucw.cz>
	<1034020510.1499.8.camel@chevrolet> <20021007220106.A1640@ucw.cz>
	<1034036449.688.8.camel@chevrolet> <20021008101711.F4290@ucw.cz>
	<1034097546.902.13.camel@chevrolet>  <20021008192512.B26021@ucw.cz>
Content-Type: multipart/mixed; boundary="=-LQ5/2/CJG6idjqNknM40"
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Oct 2002 02:54:54 +0200
Message-Id: <1034124895.668.3.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LQ5/2/CJG6idjqNknM40
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

tir, 2002-10-08 kl. 19:25 skrev Vojtech Pavlik:
> On Tue, Oct 08, 2002 at 07:18:06PM +0200, Stian Jordet wrote:
> > tir, 2002-10-08 kl. 10:17 skrev Vojtech Pavlik:
[snip]
> > > 
> > > I really wonder what your keyboard sends for those keys. To avoid the
> > > freeze (and rescanning of the keyboard), you should be able to
> > > comment-out these lines in atkbd.c:
> > > 
> > >          case ATKBD_KEY_BAT:
> > >                  serio_rescan(atkbd->serio);
> > >                  return;
> > >  
> > It didn't help at all. I just tried 2.5.41 instead of .40, and now I get
> > an Oops. Earlier it just froze. Should I write it down?
> 
> Yes!
*argh* I hate this! Just to doublecheck after I sent you the last mail
an hour or so ago, I did a recompile, fresh kernel-tree, just unrar'ed,
apply patch (just like I did earlier today), this time it Oopses again.
Every time. Earlier today, with same kernel, never any Oops. This is
incredibly weird. Anyway, here comes the Oops. I had to write it down by
hand, so it _might_ be some errors, but I really don't think so, I did
my best, and I even understood my notes when I wrote this textfile :)

Best regards,
Stian Jordet

--=-LQ5/2/CJG6idjqNknM40
Content-Disposition: attachment; filename=oops.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=oops.txt; charset=ISO-8859-1

chevrolet:~#atkbd.c: Unkknown key (set 2, scancode 0x1b6, on isa0060/serio0=
) pre
ssed.
input: AT Set 2 keyboard on isa0060/serio0
Unable to handle kernel NULL pointer dereferenced virtual address 00000004
 printing eip:
c012383f
*pde =3D 00000000
Oops: 0002

CPU:    0
EIP:    000:[<c012383f>]    Not tainted
EFLAGS: 00010002
eax: 00000000   ebx: c046ba80   ecx: c17f5298   edx: 00000000
esi: c042e000   edi: c17f5200   ebp: c02ac088   esp: c042ff3c
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=3Dc042e000 task=3Dc03dbec0)
Stack: c1506148 00000000 c042e000 00000001 00000246 c0120385 00000000 00000=
001
       c046b960 fffffffe 00000000 c04503e4 c04503e4 c012008a c046b960 00000=
000
       00000000 00000000 0008e000 00000046 c011278d c042e000 c0105320 c0105=
000
Call Trace: [<c0120385>]  [<c012008a>]  [<c011278d>]  [<c0105320>]  [<c0105=
000>]
  [<c0107be2>]  [<c01053207>]  [<c0105000>]  [<c0105349>]  [<c01053d3>]  [<=
c01050
55>]
Code: 89 50 04 89 02 c7 41 14 00 00 00 00 89 4b 08 c6 03 01 fb ff

--=-LQ5/2/CJG6idjqNknM40--

