Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131444AbQLZBM4>; Mon, 25 Dec 2000 20:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131453AbQLZBMs>; Mon, 25 Dec 2000 20:12:48 -0500
Received: from web1006.mail.yahoo.com ([128.11.23.96]:42250 "HELO
	web1006.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131444AbQLZBMc>; Mon, 25 Dec 2000 20:12:32 -0500
Message-ID: <20001226004205.12138.qmail@web1006.mail.yahoo.com>
Date: Mon, 25 Dec 2000 16:42:05 -0800 (PST)
From: Ron Calderon <ronnnyc@yahoo.com>
Subject: Re: sparc 10 w/512 megs hangs during boot
To: Ron Calderon <ronnnyc@yahoo.com>, jbglaw@lug-owl.de,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

apparently test7 has the same problem and when I
compile test6 I get these errors:
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -m32
-pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
-fno-strict-aliasing    -c -o fault.o fault.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -m32
-pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
-fno-strict-aliasing    -c -o init.o init.c
init.c: In function `kmap_init':
init.c:92: warning: unused variable `pteval'
init.c: In function `mem_init':
init.c:460: `highmem_mapnr' undeclared (first use in
this function)
init.c:460: (Each undeclared identifier is reported
only once
init.c:460: for each function it appears in.)
init.c: In function `flush_page_to_ram':
init.c:588: warning: passing arg 1 of
`___f___flush_page_to_ram' makes integer from pointer
without a cast
make[3]: *** [init.o] Error 1
make[3]: Leaving directory
`/usr/src/linux/arch/sparc/mm'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/usr/src/linux/arch/sparc/mm'
make[1]: *** [_dir_arch/sparc/mm] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2


so as far as I can see test5 is the last kernel that
can be built and booted properly on a sparc10 with
512M of ram. All others after test5 do not boot my
sparc10 with more than 128M of ram.


ron

--- Ron Calderon <ronnnyc@yahoo.com> wrote:
> test8 is borked too. I'll try test7 next
> 
> ron
> --- Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> > On Sun, Dec 24, 2000 at 12:48:44PM -0800, Ron
> > Calderon wrote:
> > > I just finished compiling 2.4.0-test5 and that
> > worked
> > > fine with 512M ram. I'll start going thru the
> > other
> > > kernels. It'll take me sometime since compileing
> > takes
> > > a long time.
> > 
> > I've not yet started active searching. However:
> > 	- test5		is fine
> > 	- test13-pre3	is not
> > 
> > I don't know how fast your machine is, but we
> should
> > coordinate out
> > search... I'll try to build -test10final (with
> > minimal config to
> > only test boot) so that shouldn't take so very
> > long... You should
> > test sth around -test8...
> > 
> > MfG, JBG
> > 
> > -- 
> > Fehler eingestehen, Größe zeigen: Nehmt die
> > Rechtschreibreform zurück!!!
> > /* Jan-Benedict Glaw <jbglaw@lug-owl.de> --
> > +49-177-5601720 */
> > keyID=0x8399E1BB fingerprint=250D 3BCF 7127 0D8C
> > A444 A961 1DBD 5E75 8399 E1BB
> >      "insmod vi.o and there we go..." (Alexander
> > Viro on linux-kernel)
> > 
> 
> > ATTACHMENT part 2 application/pgp-signature 
> 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Shopping - Thousands of Stores. Millions of
> Products.
> http://shopping.yahoo.com/
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
