Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSK3XJQ>; Sat, 30 Nov 2002 18:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSK3XJQ>; Sat, 30 Nov 2002 18:09:16 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:53777 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261292AbSK3XJP>; Sat, 30 Nov 2002 18:09:15 -0500
Date: Sat, 30 Nov 2002 21:16:23 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Christer Weinigel <wingel@nano-system.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: scx200_gpio.c doesn't compile in 2.5.50
Message-ID: <20021130231622.GO30931@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Christer Weinigel <wingel@nano-system.com>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk
References: <20021128013527.GU21307@fs.tum.de> <87of86hdvg.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87of86hdvg.fsf@zoo.weinigel.se>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 30, 2002 at 11:49:39PM +0100, Christer Weinigel escreveu:
> Adrian Bunk <bunk@fs.tum.de> writes:
> 
> > Compilation of drivers/char/scx200_gpio.c fails in 2.5.50 with the error
> > messages below.
> 
> Thanks for the report.  Patch follows.
> 
> Alan, do you want small fixes like these or should I send them to
> someone else?

Christer,

	I have this one on my misc-2.5 bk tree that I'll be pushing to Linus
RSN. It is also required that we include kdev_t.h, as this driver uses the
minor() macro.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.929, 2002-11-30 15:44:12-02:00, acme@conectiva.com.br
  o scx200_gpio: fix up header cleanups


 scx200_gpio.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/char/scx200_gpio.c b/drivers/char/scx200_gpio.c
--- a/drivers/char/scx200_gpio.c	Sat Nov 30 21:13:55 2002
+++ b/drivers/char/scx200_gpio.c	Sat Nov 30 21:13:55 2002
@@ -8,8 +8,10 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/kdev_t.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 

===================================================================


This BitKeeper patch contains the following changesets:
1.929
## Wrapped with gzip_uu ##


begin 664 bkpatch1194
M'XL(`#-&Z3T``\647V_:,!3%G_&GN!*/$XGOQ2$0C8JUF[:IDXJ8^EP9YT*B
MA@39AC(I'WX.F^A6L57[IR5YB'+LDWO/_<E]N'5LLYXV&Q9]>-<XG_5,4[/Q
MY5Y'IME$2QN$1=,$(2Z:#<>7UW%9FVJ7LQM0E(@@S[4W!>S9NJR'T?#TQ7_:
M<M9;O'E[^^'50HCI%*X*7:_Y(WN83H5O[%Y7N9MI7U1-'7FK:[=A?_QQ>UK:
MDI04[@33H4Q&+8ZD2EN#.:)6R+DD-1XIT?4P>UK[$Q?$H4057B:M5,EX+%X#
M1A.:@*08,1Y*P"13*D,:2,JDA+.F\`)A(,4E_-T&KH2!!IPYA.5WZVW99+`J
M#[#;0L$Z9PNF8EWOMDY<@THF(S%_C%,,?O$20FHI+L`4MG2>[>R!R[I<<Q4Y
M;G-;=L.,3:%M_$U!D?F2HCRVDI!LAY02M4O#(V*3:EP9GJCE^=B>M>V&DRH*
MAC+%T%\'S(_W=`3]D^K_S!7;0%<BCV31]UQ11L]P1?^;JV/N-S"P#\<G<#+_
MR0A^@[KW&+(0_:\G"+RLRGIWB%<N*BZ"1F>T^YSW=[[33^>**=C<N]UF.M9$
-B<1$?`;,]'GCR00`````
`
end
