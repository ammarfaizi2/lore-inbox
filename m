Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTANUqo>; Tue, 14 Jan 2003 15:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265205AbTANUqo>; Tue, 14 Jan 2003 15:46:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3463 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264646AbTANUqm>; Tue, 14 Jan 2003 15:46:42 -0500
Date: Tue, 14 Jan 2003 15:56:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Philippe Troin <phil@fifi.org>
cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
In-Reply-To: <87iswrzdf1.fsf@ceramic.fifi.org>
Message-ID: <Pine.LNX.3.95.1030114154840.14093A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jan 2003, Philippe Troin wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > On Tue, 14 Jan 2003, DervishD wrote:
> > 
> > >     Hi all :))
> > > 
> > >     I'm not sure whether this issue belongs to the kernel or to the
> > > libc, but I think that is more on the kernel side, that's why I ask
> > > here.
> > > 
> > 
> > Last time I checked argv[0] was 512 bytes. Many daemons overwrite
> > it with no problem.
> 
> Last time must have been in an alternate reality.
> 
> You just overwrote all your arguments (argv[0] and others) and part of
> the environment.
> 
It seems to depend upon the machine, maybe the 'C' runtime library.

uname -a
Linux chaos 2.4.18 #15 SMP Mon Jul 15 14:19:43 EDT 2002 i686
This machine is a composite, made from stuff dating back over
5 years, but with two 'C' runtime library updates and many
of the programs/utilities re-compiled.

Script started on Tue Jan 14 15:45:11 2003
[9;0]# xxx
ENV before: LOGNAME=root
ENV before: NLSPATH=/usr/man:/usr/X11/man:/usr/openwin/man:/opt/schily/man
ENV before: MINICOM=-c on
ENV before: VISUAL=/bin/vi
ENV before: MAIL=/var/spool/mail/root
ENV before: LD_LIBRARY_PATH=/lib:/usr/lib/:/opt/intel/compiler50/ia32/lib:/usr/X11R6/lib:/opt/Office50/lib:/usr/java/lib/i686
ENV before: TERMCAP=vt100|vt100-am|dec vt100 (w/advanced video):am:mi:ms:xn:xo:co#80:it#8:li#25:vt#3:@8=\EOM:DO=\E[%dB:K1=\EOq:K2=\EOr:K3=\EOs:K4=\EOp:K5=\EOn:LE=\E[%dD:RI=\E[%dC:UP=\E[%dA:ac=\140\140aaffggjjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~:ae=^O:
as=^N:bl=^G:cb=\E[1K:cd=\E[J:ce=\E[K:cl=\E[H\E[J:cm=\E[%i%d;%dH:cr=^M:cs=\E[%i%d;%dr:ct=\E[3g:do=^J:eA=\E(B\E)0:ho=\E[H:k0=\EOy:k1=\EOP:k2=\EOQ:k3=\EOR:k4=\EOS:k5=\EOt:k6=\EOu:k7=\EOv:k8=\EOl:k9=\EOw:k;=\EOx:kb=^H:kd=\EOB:ke=\E[?1l\E>:kl=\EOD:kr=\EOC:ks=\
E[?1h\E=:ku=\EOA:le=^H:mb=\E[5m:md=\E[1m:me=\E[m\017:mr=\E[7m:nd=\E[C:is=\E<\E)0:r2=\E>\E[?3l\E[?4l\E[?5l\E[?7h\E[?8h:rc=\E8:sc=\E7:se=\E[m:sf=^J:so=\E[1;7m:sr=\EM:st=\EH:ta=^I:ue=\E[m:up=\E[A:us=\E[4m:
ENV before: TERM=vt100-am
ENV before: HOSTTYPE=i386
ENV before: PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/opt/schily/bin:/usr/bin/X11:/sbin/:/usr/TeX/bin:/usr/openwin/bin:/opt/intel/compiler50/ia32/bin:/usr/games:.:/usr/local/Office50/bin:/usr/java/bin:/home/users/root/tools:/home/users/root/tools

ENV before: PRINTER=mcd
ENV before: HOME=/root
ENV before: PS_SYSTEM_MAP=/System.map
ENV before: SHELL=/bin/bash
ENV before: LINES=25
ENV before: PS1=# 
ENV before: PS2=> 
ENV before: MANPATH=/usr/man:/usr/X11/man:/usr/openwin/man:/opt/schily/man
ENV before: LESS=-MM
ENV before: COLUMNS=80
ENV before: LIB=/usr/X11R6/lib:/usr/X11/lib:/usr/X11/lib
ENV before: GNUHELP=/usr/local/lib/gnuplot/gnuplot.gih
ENV before: JAVA_HOME=/usr/java
ENV before: DISPLAY=:0
ENV before: LANG=en_US.88591
ENV before: OSTYPE=Linux
ENV before: OPENWINHOME=/usr/openwin
ENV before: SHLVL=2
ENV before: EDITOR=/bin/vi
ENV before: LS_COLORS=no=00:fi=40;32:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;33:*.cmd=01;32:*.o=40;32:*.c=01;26:*.S=01;26:*.h=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=0
1;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:
ENV before: TZ=US/Eastern
ENV before: _=./xxx
ENV after: LOGNAME=root
ENV after: NLSPATH=/usr/man:/usr/X11/man:/usr/openwin/man:/opt/schily/man
ENV after: MINICOM=-c on
ENV after: VISUAL=/bin/vi
ENV after: MAIL=/var/spool/mail/root
ENV after: LD_LIBRARY_PATH=/lib:/usr/lib/:/opt/intel/compiler50/ia32/lib:/usr/X11R6/lib:/opt/Office50/lib:/usr/java/lib/i686
ENV after: TERMCAP=vt100|vt100-am|dec vt100 (w/advanced video):am:mi:ms:xn:xo:co#80:it#8:li#25:vt#3:@8=\EOM:DO=\E[%dB:K1=\EOq:K2=\EOr:K3=\EOs:K4=\EOp:K5=\EOn:LE=\E[%dD:RI=\E[%dC:UP=\E[%dA:ac=\140\140aaffggjjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~:ae=^O:a
s=^N:bl=^G:cb=\E[1K:cd=\E[J:ce=\E[K:cl=\E[H\E[J:cm=\E[%i%d;%dH:cr=^M:cs=\E[%i%d;%dr:ct=\E[3g:do=^J:eA=\E(B\E)0:ho=\E[H:k0=\EOy:k1=\EOP:k2=\EOQ:k3=\EOR:k4=\EOS:k5=\EOt:k6=\EOu:k7=\EOv:k8=\EOl:k9=\EOw:k;=\EOx:kb=^H:kd=\EOB:ke=\E[?1l\E>:kl=\EOD:kr=\EOC:ks=\E
[?1h\E=:ku=\EOA:le=^H:mb=\E[5m:md=\E[1m:me=\E[m\017:mr=\E[7m:nd=\E[C:is=\E<\E)0:r2=\E>\E[?3l\E[?4l\E[?5l\E[?7h\E[?8h:rc=\E8:sc=\E7:se=\E[m:sf=^J:so=\E[1;7m:sr=\EM:st=\EH:ta=^I:ue=\E[m:up=\E[A:us=\E[4m:
ENV after: TERM=vt100-am
ENV after: HOSTTYPE=i386
ENV after: PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/opt/schily/bin:/usr/bin/X11:/sbin/:/usr/TeX/bin:/usr/openwin/bin:/opt/intel/compiler50/ia32/bin:/usr/games:.:/usr/local/Office50/bin:/usr/java/bin:/home/users/root/tools:/home/users/root/tools
ENV after: PRINTER=mcd
ENV after: HOME=/root
ENV after: PS_SYSTEM_MAP=/System.map
ENV after: SHELL=/bin/bash
ENV after: LINES=25
ENV after: PS1=# 
ENV after: PS2=> 
ENV after: MANPATH=/usr/man:/usr/X11/man:/usr/openwin/man:/opt/schily/man
ENV after: LESS=-MM
ENV after: COLUMNS=80
ENV after: LIB=/usr/X11R6/lib:/usr/X11/lib:/usr/X11/lib
ENV after: GNUHELP=/usr/local/lib/gnuplot/gnuplot.gih
ENV after: JAVA_HOME=/usr/java
ENV after: DISPLAY=:0
ENV after: LANG=en_US.88591
ENV after: OSTYPE=Linux
ENV after: OPENWINHOME=/usr/openwin
ENV after: SHLVL=2
ENV after: EDITOR=/bin/vi
ENV after: LS_COLORS=no=00:fi=40;32:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;33:*.cmd=01;32:*.o=40;32:*.c=01;26:*.S=01;26:*.h=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01
;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:
ENV after: TZ=US/Eastern
ENV after: _=./xxx

# exit
Script done on Tue Jan 14 15:45:48 2003

My Sun.......

Script started on Tue Jan 14 15:47:18 2003
# uname -a
SunOS hal 5.5.1 Generic sun4m sparc SUNW,SPARCstation-5
# ./xxx
ENV before: HOME=/
ENV before: HZ=100
ENV before: LD_LIBRARY_PATH=/usr/ucblib:/usr/lib:/usr/local/lib:/usr/local/lib/gcc-lib:/lib
ENV before: LOGNAME=root
ENV before: MAIL=/var/mail/root
ENV before: PATH=/usr/bin:/usr/local/bin:/usr/sbin:/usr/ccs/bin:/usr/openwin/bin:/sbin/:.
ENV before: SHELL=/sbin/sh
ENV before: TERM=vt100-am
ENV before: TZ=US/Eastern
ENV after: ng-do-you-want-this-string-to-be?--is-this-long-enough?
ENV after: ou-want-this-string-to-be?--is-this-long-enough?
ENV after: -this-string-to-be?--is-this-long-enough?
ENV after: LOGNAME=root
ENV after: MAIL=/var/mail/root
ENV after: PATH=/usr/bin:/usr/local/bin:/usr/sbin:/usr/ccs/bin:/usr/openwin/bin:/sbin/:.
ENV after: SHELL=/sbin/sh
ENV after: TERM=vt100-am
ENV after: TZ=US/Eastern
^C# exit
script done on Tue Jan 14 15:47:34 2003

My red-hat 7.0 machine shows the environment overwrite also.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


