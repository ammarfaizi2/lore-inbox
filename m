Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130875AbRCFCTK>; Mon, 5 Mar 2001 21:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130873AbRCFCTA>; Mon, 5 Mar 2001 21:19:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29056 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130875AbRCFCSp>; Mon, 5 Mar 2001 21:18:45 -0500
Date: Mon, 5 Mar 2001 21:18:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert Read <rread@datarithm.net>
cc: Pozsar Balazs <pozsy@sch.bme.hu>, Paul Flinders <P.Flinders@ftel.co.uk>,
        Jeff Mcadams <jeffm@iglou.com>, Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305123907.C6400@tenchi.datarithm.net>
Message-ID: <Pine.LNX.3.95.1010305211222.4500A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Robert Read wrote:

> On Mon, Mar 05, 2001 at 07:58:52PM +0100, Pozsar Balazs wrote:
> > 
> > And what does POSIX say about "#!/bin/sh\r" ?
> > In other words: should the kernel look for the interpreter between the !
> > and the newline, or [the first space or newline] or the first whitespace?
> > 
> > IMHO, the first whitespace. Which means that "#!/bin/sh\r" should invoke
> > /bin/sh. (though it is junk).
> > 
> 
> The line terminator, '\n', is what terminates the interpreter.  White
> space (in this case, only ' ' and '\t') is used to seperate the
> arguments to the interpreter.  This allows scripts to pass args to
> intepreters, as in #!/usr/bin/per -w or #!/usr/bin/env perl -w
> 
> So is '\r' a line terminator? For Linux, no.  Should '\r' seperate
> arguments?  No, that would be very strange.
> 

For research, I suggest a look at getopt(3) or whatever it's called.
The command line args are seperated into chunks based upon what got
seperated into argv[1]....[n], delimited by (hold my breath) white-space.

Of course, it's not getopt(), but "makeopt()" that we are looking for.
...Whatever chopped up those command-line arguments in the first place.

If __that__ corresponds so POSIX rules, then whatever follows must
also comply.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


