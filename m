Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRCEQBK>; Mon, 5 Mar 2001 11:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129373AbRCEQA6>; Mon, 5 Mar 2001 11:00:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:20610 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129363AbRCEQAr>; Mon, 5 Mar 2001 11:00:47 -0500
Date: Mon, 5 Mar 2001 10:59:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jan Nieuwenhuizen <janneke@gnu.org>
cc: Pavel Machek <pavel@suse.cz>, Erik Hensema <erik@hensema.xs4all.nl>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: [PATCH]: print missing interpreter name [Was: Re: binfmt_script and ^M]
In-Reply-To: <m3vgpo462x.fsf@appel.lilypond.org>
Message-ID: <Pine.LNX.3.95.1010305105132.9913B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Mar 2001, Jan Nieuwenhuizen wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > So why would you even consider breaking bash as a work-around for
> > a broken script?
> 
> I don't.
> 
> > Somebody must have missed the boat entirely. Unix does not, never
> > has, and never will end a text line with '\r'. It's Microsoft junk
> > that does that, a throwback to CP/M, a throwback to MDS/200.
> 
> Yes, we all know that, but you missed the point.  As far as this patch
> goes, it's got nothing to do with the '\r'.  It's meant to get a more
> informative error message from bash, if ``#!INTERPRETER'' does not
> exist.  Look:
> 
>     $ cat /bin/foo.sh
>     #!/foo/bar/baz
>     echo bar
>     $ /bin/bash -c /bin/foo.sh 
>     /bin/bash: /bin/foo.sh: No such file or directory
>     $ ./build/bash -c /bin/foo.sh 
>     ./build/bash: /foo/bar: No such file or directory
> 
> Maybe the message could even be better, but having `/foo/bar' printed,
> ie, the file that the kernel says does not exist, iso `/bin/foo.sh',
> the name of the script, that certainly does exist, may help.  Possibly
> both should be printed.
> 
> Greetings,
> Jan.

No. I did not miss the point. The 'No such file or directory' error
(when you can see the ^$^$)#@@*& filename with 'ls'), usually means
that there is something wrong with the file. Usually, I have found
that it was an executable linked against some other runtime library
than what I have. `strace` finds this quickly.

A common problem after a so-called upgrade. So, the bash error output
(without additional text) is consistent when there is something wrong with
the file-name as well. 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


