Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131127AbQLDHry>; Mon, 4 Dec 2000 02:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131131AbQLDHrp>; Mon, 4 Dec 2000 02:47:45 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:9223
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131127AbQLDHr1>; Mon, 4 Dec 2000 02:47:27 -0500
Date: Sun, 3 Dec 2000 23:16:37 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: e.ckhard@u-code.de
cc: marcel@mesa.nl, linux-kernel@vger.kernel.org
Subject: Re: IDE_TAPE problem wiht ONSTREAM DI30
In-Reply-To: <00120321222000.00506@eckhard>
Message-ID: <Pine.LNX.4.10.10012032315100.13699-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2000, Eckhard Jokisch wrote:

> Am Don, 30 Nov 2000 schrieben Sie:
> > On Thu, Nov 30, 2000 at 04:26:09PM +0000, Eckhard Jokisch wrote:
> > > 
> > > I tried the ide-tape driver for several weeks now. And after some time during
> > > writing or reading tar stops because of errors.
> > > 
> > > Error messages are:
> > > Nov 30 15:32:20  kernel: ide-tape: ht0: I/O error, pc =  8, key =  0,
> > > asc =  0, ascq =  2 Nov 30 15:32:25 eckhard last message repeated 1000 times
> > > Nov 30 15:32:25  kernel: ide-tape: ht0: unrecovered read error on logical block number 461706, skipping

You have to love the new ARD media...

> ....
> 
> > I ran into such problems since februari or so and have been in contact with
> > the ide-tape developers and Onstream about it. 
> > I recently volunteered to try improving the end of media handling (basicly by
> > implementing early warning EOM) but so far have not had much time to work on it...
> 
> Where can I start to do that? 
> Can you tell me how I can set the debug_level to 3 or 5?
> Why do I get this errors on make modules when I compile the driver with
> IDETAPE_DEBUG_LOG_VERBOSE to 1 in ide-tape.c?: gcc -D__KERNEL__
> -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
> -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686
> -malign-functions=4  -DMODULE -DMODVERSIONS -include
> /usr/src/linux/include/linux/modversions.h   -c -o ide-tape.o ide-tape.c
> ide-tape.c: In function `idetape_sense_key_verbose': ide-tape.c:1395: warning:
> function returns address of local variable ide-tape.c: In function
> `idetape_command_key_verbose': ide-tape.c:1413: parse error before `case'
> ide-tape.c:1424: warning: function returns address of local variable make[2]:
> *** [ide-tape.o] Error 1 make[2]: Leaving directory
> `/src/2.4-test11/drivers/ide' make[1]: *** [_modsubdir_ide] Error 2 make[1]:
> Leaving directory `/src/2.4-test11/drivers' make: *** [_mod_drivers] Error 2

This I can fix, but the decoding noise makers are still in progress.

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
