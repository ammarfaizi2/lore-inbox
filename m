Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287254AbSAZWyw>; Sat, 26 Jan 2002 17:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287276AbSAZWyn>; Sat, 26 Jan 2002 17:54:43 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:25875 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S287254AbSAZWy2>;
	Sat, 26 Jan 2002 17:54:28 -0500
Date: Sat, 26 Jan 2002 23:52:32 +0100
From: Stefan Frank <sfr@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18pre3-ac2 : stuck when mounting NFS v3 via automounter
Message-ID: <20020126225232.GA1017@obelix.gallien.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

quite regularly my server (2.4.18-pre3-ac2 SMP) locks up hard.
No response over the net, keyboard is dead, except the SysReq.
And nothing appears in the logs.

I think it _may_ be related to NFS, as it happened now a few times when
i started mutt on another machine (My mail is stored on the server
and is automounted (NFS v3) on the client (also running 2.4.18-pre3-ac2 UP)

In addition, every now and then messages like below are logged:

Jan 23 13:06:47 asterix kernel: NFS: server cheating in read reply: 
       count 270336 > recvd 8680

Jan 12 22:36:47 asterix kernel: call_verify: server accept status: 2

Jan 13 12:43:49 asterix kernel: expected (0x808/0x1c0b6), got 
       (0x4000000040808/0x400000001c0b6)

Anyone can tell me what they mean?

The last changes to NFS are in 2.4.18-pre1, according to Marcelo's 
Changelog. Is there anyting i could try (different kernels, patches)?

Please note that this happens since around 2.4.something, i just
always hoped that it would be fixed with the next release.

Bye, Stefan

obelix:/home/sfr# ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux obelix 2.4.18-pre3-ac2 #1 SMP Mit Jan 16 00:16:23 CET 2002 i686
unknown
 
/usr/local/bin/ver_linux: gcc: command not found

Kernel compiled on another machine:
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4  (Debian prerelease)

Gnu C                 
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.25
pcmcia-cs              3.1.28
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ide-probe-mod ide-mod ipt_TOS iptable_mangle
ipt_REDIRECT ipt_MASQUERADE iptable_nat ipt_state ip_conntrack ipt_LOG
ipt_limit iptable_filter ip_tables ospm_processor ospm_button
ospm_system ospm_busmgr rtc


Here are the compile options from mutt:

sfr@asterix:~$ mutt -v
Mutt 1.3.25i (2002-01-01)
Copyright (C) 1996-2001 Michael R. Elkins und andere.
Mutt bernimmt KEINERLEI GEWHRLEISTUNG. Starten Sie `mutt -vv', um
weitere Details darber zu erfahren. Mutt ist freie Software. 
Sie knnen es unter bestimmten Bedingungen weitergeben; starten Sie
`mutt -vv' fr weitere Details.

System: Linux 2.4.18-pre3-ac2 (i686) [using ncurses 5.2]
Einstellungen bei der Compilierung:
-DOMAIN
+DEBUG
-HOMESPOOL  +USE_SETGID  +USE_DOTLOCK  +DL_STANDALONE  
+USE_FCNTL  -USE_FLOCK
+USE_POP  +USE_IMAP  -USE_GSS  -USE_SSL  +USE_GNUTLS  +USE_SASL  
+HAVE_REGCOMP  -USE_GNU_REGEX  
+HAVE_COLOR  +HAVE_START_COLOR  +HAVE_TYPEAHEAD  +HAVE_BKGDSET  
+HAVE_CURS_SET  +HAVE_META  +HAVE_RESIZETERM  
+HAVE_PGP  -BUFFY_SIZE -EXACT_ADDRESS  -SUN_ATTACHMENT  
+ENABLE_NLS  -LOCALES_HACK  +COMPRESSED  +HAVE_WC_FUNCS
+HAVE_LANGINFO_CODESET  +HAVE_LANGINFO_YESEXPR  
+HAVE_ICONV  -ICONV_NONTRANS  +HAVE_GETSID  +HAVE_GETADDRINFO  
ISPELL="/usr/bin/ispell"
SENDMAIL="/usr/sbin/sendmail"
MAILPATH="/var/mail"
PKGDATADIR="/usr/share/mutt"
SYSCONFDIR="/etc"
EXECSHELL="/bin/sh"
MIXMASTER="mixmaster"
Um die Entwickler zu kontaktieren, schicken Sie bitte
eine Nachricht (in englisch) an <mutt-dev@mutt.org>.
Um einen Bug zu melden, verwenden Sie bitte das Programm flea(1).

patch-1.3.24.rr.compressed.1
patch-1.3.24.appoct.2
patch-1.3.15.sw.pgp-outlook.1
patch-1.3.25.chip.fast-limited-threads
patch-1.3.25.admcd.gnutls.14
Md.use_editor
Md.paths_mutt.man
Md.muttbug_no_list
Md.use_etc_mailname
Md.muttbug_warning
Md.gpg_status_fd
patch-1.3.25.cd.edit_threads.9.1
patch-1.2.xtitles.1
patch-1.3.23.1.ametzler.pgp_good_sign
sfr@asterix:~$ 

