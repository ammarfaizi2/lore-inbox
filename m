Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130271AbQLCUvX>; Sun, 3 Dec 2000 15:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130764AbQLCUvO>; Sun, 3 Dec 2000 15:51:14 -0500
Received: from u-code.de ([207.159.137.250]:8945 "EHLO u-code.de")
	by vger.kernel.org with ESMTP id <S130271AbQLCUvG>;
	Sun, 3 Dec 2000 15:51:06 -0500
From: Eckhard Jokisch <eckhard@u-code.de>
Reply-To: e.ckhard@u-code.de
Organization: u-code
To: marcel@mesa.nl, linux-kernel@vger.kernel.org
Subject: Re: IDE_TAPE problem wiht ONSTREAM DI30
Date: Sun, 3 Dec 2000 21:07:59 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <00113016484200.11054@eckhard> <20001130170539.C25168@joshua.mesa.nl>
In-Reply-To: <20001130170539.C25168@joshua.mesa.nl>
MIME-Version: 1.0
Message-Id: <00120321222000.00506@eckhard>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 30 Nov 2000 schrieben Sie:
> On Thu, Nov 30, 2000 at 04:26:09PM +0000, Eckhard Jokisch wrote:
> > 
> > I tried the ide-tape driver for several weeks now. And after some time during
> > writing or reading tar stops because of errors.
> > 
> > Error messages are:
> > Nov 30 15:32:20  kernel: ide-tape: ht0: I/O error, pc =  8, key =  0,
> > asc =  0, ascq =  2 Nov 30 15:32:25 eckhard last message repeated 1000 times
> > Nov 30 15:32:25  kernel: ide-tape: ht0: unrecovered read error on logical block number 461706, skipping

....

> I ran into such problems since februari or so and have been in contact with
> the ide-tape developers and Onstream about it. 
> I recently volunteered to try improving the end of media handling (basicly by
> implementing early warning EOM) but so far have not had much time to work on it...

Where can I start to do that? 
Can you tell me how I can set the debug_level to 3 or 5?
Why do I get this errors on make modules when I compile the driver with
IDETAPE_DEBUG_LOG_VERBOSE to 1 in ide-tape.c?: gcc -D__KERNEL__
-I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux/include/linux/modversions.h   -c -o ide-tape.o ide-tape.c
ide-tape.c: In function `idetape_sense_key_verbose': ide-tape.c:1395: warning:
function returns address of local variable ide-tape.c: In function
`idetape_command_key_verbose': ide-tape.c:1413: parse error before `case'
ide-tape.c:1424: warning: function returns address of local variable make[2]:
*** [ide-tape.o] Error 1 make[2]: Leaving directory
`/src/2.4-test11/drivers/ide' make[1]: *** [_modsubdir_ide] Error 2 make[1]:
Leaving directory `/src/2.4-test11/drivers' make: *** [_mod_drivers] Error 2

Hopefully
Eckhard
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
