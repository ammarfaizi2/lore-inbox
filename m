Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTD1Omj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 10:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTD1Omj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 10:42:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31629 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261156AbTD1OmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 10:42:25 -0400
Date: Mon, 28 Apr 2003 10:56:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Valdis.Kletnieks@vt.edu
cc: Andreas Schwab <schwab@suse.de>, Mark Grosberg <mark@nolab.conman.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall. 
In-Reply-To: <200304281438.h3SEcFdA003667@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.53.0304281045590.16997@chaos>
References: <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org>
 <Pine.LNX.4.53.0304280855240.16444@chaos> <jed6j67o4o.fsf@sykes.suse.de>
 <Pine.LNX.4.53.0304280951500.16637@chaos> <jeadea7mj3.fsf@sykes.suse.de>  
          <Pine.LNX.4.53.0304281001200.16752@chaos>
 <200304281438.h3SEcFdA003667@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Apr 2003 Valdis.Kletnieks@vt.edu wrote:

> On Mon, 28 Apr 2003 10:16:21 EDT, "Richard B. Johnson" said:
>
> > Read the bash documentation `man bash`. The first argument becomes
> > $0 (the process name), the second becomes $1, etc. Please  don't
> > just keep assuming that I don't know what I'm talking about.
> >
> > $ sh -c 'ignore echo a b c'
> > Works fine.
>
> [~]2 /bin/bash -c ignore echo a b c
> echo: line 1: ignore: command not found
> [~]2 /bin/bash -c 'ignore echo a b c'
> /bin/bash: line 1: ignore: command not found
>
> Obviously, tokenization makes a difference here. ;)
>
> So let's try forcing $0 to /bin/bash rather than 'ignore'...
>
> [~]2 sh -c '/bin/bash echo a b c'
> echo: /bin/echo: cannot execute binary file
>
> Correct, but unexpected results..
>
> [~]2 sh -c /bin/echo echo a b c
>
> [~]2 sh -c '/bin/echo a b c'
> a b c
>
> Again, tokenization matters - try working out what the value of argc is
> for the exec of /bin/bash for each of these cases...
>
> Dick, do you have an 'ignore' in your $PATH?
>

No:
BASH=/bin/bash
BASH_VERSION=1.14.5(1)
COLUMNS=80
DISPLAY=:0
EDITOR=/bin/vi
EUID=0
GNUHELP=/usr/local/lib/gnuplot/gnuplot.gih
HISTFILE=
HISTFILESIZE=0
HISTSIZE=500
HOME=/root
HOSTTYPE=i386
IFS=

JAVA_HOME=/usr/java
LANG=en_US.88591
LD_LIBRARY_PATH=/lib:/usr/lib/:/opt/intel/compiler50/ia32/lib:/usr/X11R6/lib:/opt/Office50/lib:/usr/java/lib/i686
LESS=-MM
LIB=/usr/X11R6/lib:/usr/X11/lib
LINES=25
LOGNAME=root
LS_COLORS=no=00:fi=40;32:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;33:*.cmd=01;32:*.o=40;32:*.c=01;26:*.S=01;26:*.h=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:
MAIL=/var/spool/mail/root
MAILCHECK=60
MANPATH=/usr/man:/usr/X11/man:/usr/openwin/man:/opt/schily/man
MINICOM=-c on
NLSPATH=/usr/man:/usr/X11/man:/usr/openwin/man:/opt/schily/man
OPENWINHOME=/usr/openwin
OPTERR=1
OPTIND=1
OSTYPE=Linux
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/opt/schily/bin:/usr/bin/X11:/sbin/:/usr/TeX/bin:/usr/openwin/bin:/opt/intel/compiler50/ia32/bin:/usr/games:.:/usr/local/Office50/bin:/usr/java/bin:/home/users/root/tools
PPID=1
PRINTER=mcd
PS1=#
PS2=>
PS4=+
PS_SYSTEM_MAP=/System.map
PWD=/root
SHELL=/bin/bash
SHLVL=1
TERM=vt100-am
TERMCAP=vt100|vt100-am|dec vt100 (w/advanced video):am:mi:ms:xn:xo:co#80:it#8:li#25:vt#3:@8=\EOM:DO=\E[%dB:K1=\EOq:K2=\EOr:K3=\EOs:K4=\EOp:K5=\EOn:LE=\E[%dD:RI=\E[%dC:UP=\E[%dA:ac=\140\140aaffggjjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~:ae=^O:as=^N:bl=^G:cb=\E[1K:cd=\E[J:ce=\E[K:cl=\E[H\E[J:cm=\E[%i%d;%dH:cr=^M:cs=\E[%i%d;%dr:ct=\E[3g:do=^J:eA=\E(B\E)0:ho=\E[H:k0=\EOy:k1=\EOP:k2=\EOQ:k3=\EOR:k4=\EOS:k5=\EOt:k6=\EOu:k7=\EOv:k8=\EOl:k9=\EOw:k;=\EOx:kb=^H:kd=\EOB:ke=\E[?1l\E>:kl=\EOD:kr=\EOC:ks=\E[?1h\E=:ku=\EOA:le=^H:mb=\E[5m:md=\E[1m:me=\E[m\017:mr=\E[7m:nd=\E[C:is=\E<\E)0:r2=\E>\E[?3l\E[?4l\E[?5l\E[?7h\E[?8h:rc=\E8:sc=\E7:se=\E[m:sf=^J:so=\E[1;7m:sr=\EM:st=\EH:ta=^I:ue=\E[m:up=\E[A:us=\E[4m:
TZ=US/Eastern
UID=0
VISUAL=/bin/vi
notify=1


Same behavior with:

BASH=/bin/bash
BASH_VERSION=1.14.5(1)
COLUMNS=80
DISPLAY=:0
EDITOR=/bin/vi
EUID=0
GNUHELP=/usr/local/lib/gnuplot/gnuplot.gih
HISTFILE=
HISTFILESIZE=0
HISTSIZE=500
HOME=/root
HOSTTYPE=i386
IFS=

JAVA_HOME=/usr/java
LANG=en_US.88591
LD_LIBRARY_PATH=/lib:/usr/lib/:/opt/intel/compiler50/ia32/lib:/usr/X11R6/lib:/opt/Office50/lib:/usr/java/lib/i686
LESS=-MM
LIB=/usr/X11R6/lib:/usr/X11/lib
LINES=25
LOGNAME=root
LS_COLORS=
MAIL=/var/spool/mail/root
MAILCHECK=60
MANPATH=
MINICOM=-c on
NLSPATH=
OLDPWD=/root/assembly
OPENWINHOME=/usr/openwin
OPTERR=1
OPTIND=1
OSTYPE=Linux
PATH=
PPID=1
PRINTER=mcd
PS1=#
PS2=>
PS4=+
PS_SYSTEM_MAP=/System.map
PWD=/root
SHELL=/bin/bash
SHLVL=1
TERM=
TERMCAP=
TZ=
UID=0
VISUAL=
_=echo 1 2 3 4
notify=1


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

