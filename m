Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWBJLEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWBJLEF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWBJLEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:04:05 -0500
Received: from vls08.wavecon.de ([193.239.104.30]:44687 "EHLO vls08.wavecon.de")
	by vger.kernel.org with ESMTP id S1751351AbWBJLEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:04:02 -0500
Message-ID: <43EC7312.5010109@roessner-net.com>
Date: Fri, 10 Feb 2006 12:03:46 +0100
From: Christian Roessner <christian@roessner-net.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@infradead.org>
CC: Johannes Stezenbach <js@linuxtv.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Bug in saa7134/tuner (Pinnacle MediaCenter 300i)
References: <20060209152324.58b1ab78.akpm@osdl.org> <1139530309.6629.1.camel@localhost>
In-Reply-To: <1139530309.6629.1.camel@localhost>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=6B929997
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF092EBF6A94DFF5D4ACA73B4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF092EBF6A94DFF5D4ACA73B4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

while searching for more information on this bug, I found this in my
/var/log/syslog. Maybe it has something to do with the problems I have.

Feb  9 18:41:37 amd64 udevd-event[14337]: wait_for_sysfs: waiting for
'/sys/devices/pci0000:00/0000:00:0e.0/0000:02:0a.0/i2c-2/2-0047/bus' fail=
ed

lspci matches on this:
02:0a.0 Multimedia controller: Philips Semiconductors SAA7134 Video
Broadcast Decoder (rev 01)

I let the old mail text appended (tell me please, if to throw it away in
possible future replies)

Regards

Christian

Mauro Carvalho Chehab schrieb:
> Christian,
>=20
> 	May you try this patch?
>=20
> Cheers,
> Mauro.
>=20
> Em Qui, 2006-02-09 =C3=A0s 15:23 -0800, Andrew Morton escreveu:
>> Begin forwarded message:
>>
>> Date: Thu, 09 Feb 2006 12:00:01 +0100
>> From: Christian Roessner <christian@roessner-net.com>
>> To: linux-kernel@vger.kernel.org
>> Subject: Bug in saa7134/tuner (Pinnacle MediaCenter 300i)
>>
>>
>> Hello,
>>
>> [1.] One line summary of the problem:
>> saa7134 and tuner modules / Problem with Pinnacle MediaCenter 300i
>>
>>
>> [2.] Full description of the problem/report:
>> After starting the computer, I do a modprobe saa7134.
>>
>> These are the options from /etc/modprobe.conf:
>> options tuner no_autodetect=3D33
>> options saa7134 card=3D50 tuner=3D33
>>
>> (Autodetection for card=3D works, but I set it anyways. Tuner
>> autodetection seems to be broken)
>>
>> dmesg output:
>>
>> Linux video capture interface: v1.00
>> saa7130/34: v4l2 driver version 0.2.14 loaded
>> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 19
>> ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [LNKA] -> GSI 19 (level,
>> low) -> IRQ 17
>> saa7134[0]: found at 0000:02:0a.0, rev: 1, irq: 17, latency: 64, mmio:=

>> 0xfeaff800
>> saa7134[0]: subsystem: 11bd:002d, board: Pinnacle PCTV 300i DVB-T + PA=
L
>> [card=3D50,insmod option]
>> saa7134[0]: board init: gpio is c806000
>> saa7134[0]: i2c eeprom 00: bd 11 2d 00 f8 f8 1c 00 43 43 a9 1c 55 d2 b=
2 92
>> saa7134[0]: i2c eeprom 10: 00 f0 04 04 ff 20 ff ff ff ff ff ff ff ff f=
f ff
>> saa7134[0]: i2c eeprom 20: 01 40 01 02 03 ff 03 01 08 ff 00 25 ff ff f=
f ff
>> saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff
>> saa7134[0]: i2c eeprom 40: ff 16 00 c0 86 3c 01 01 ff ff ff ff ff ff f=
f ff
>> saa7134[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff
>> saa7134[0]: i2c eeprom 60: 0c 22 17 44 03 27 36 95 ff ff ff ff ff ff f=
f ff
>> saa7134[0]: i2c eeprom 70: 00 30 8d 18 cc d8 ff ff f4 b8 ff ff ff ff f=
f ff
>> tuner 2-0043: chip found @ 0x86 (saa7134[0])
>> tuner 2-0043: microtune: companycode=3De0e0 part=3De0 rev=3De0
>> tuner 2-0043: microtune unknown found, not (yet?) supported, sorry :-/=

>> saa7134[0]/irq[10,4297703459]: r=3D0x20 s=3D0x00 PE
>> saa7134[0]/irq: looping -- clearing PE (parity error!) enable bit
>> saa7134[0]: registered device video0 [v4l2]
>> saa7134[0]: registered device vbi0
>>
>> As you can see, the tuner does not work. I do a rmmod tuner and a rmmo=
d
>> saa7134 and do a modprobe saa7134 again:
>>
>> dmesg output:
>>
>> saa7130/34: v4l2 driver version 0.2.14 loaded
>> ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [LNKA] -> GSI 19 (level,
>> low) -> IRQ 17
>> saa7134[0]: found at 0000:02:0a.0, rev: 1, irq: 17, latency: 64, mmio:=

>> 0xfeaff800
>> saa7134[0]: subsystem: 11bd:002d, board: Pinnacle PCTV 300i DVB-T + PA=
L
>> [card=3D50,insmod option]
>> saa7134[0]: board init: gpio is c806000
>> tda9887 2-0043: chip found @ 0x86 (saa7134[0])
>> saa7134[0]: i2c eeprom 00: bd 11 2d 00 f8 f8 1c 00 43 43 a9 1c 55 d2 b=
2 92
>> saa7134[0]: i2c eeprom 10: 00 f0 04 04 ff 20 ff ff ff ff ff ff ff ff f=
f ff
>> saa7134[0]: i2c eeprom 20: 01 40 01 02 03 ff 03 01 08 ff 00 25 ff ff f=
f ff
>> saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff
>> saa7134[0]: i2c eeprom 40: ff 16 00 c0 86 3c 01 01 ff ff ff ff ff ff f=
f ff
>> saa7134[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff
>> saa7134[0]: i2c eeprom 60: 0c 22 17 44 03 27 36 95 ff ff ff ff ff ff f=
f ff
>> saa7134[0]: i2c eeprom 70: 00 30 8d 18 cc d8 ff ff f4 b8 ff ff ff ff f=
f ff
>> tuner 2-0060: chip found @ 0xc0 (saa7134[0])
>> tuner 2-0060: microtune: companycode=3D3cbf part=3D42 rev=3D83
>> tuner 2-0060: microtune MT2050 found, OK
>> saa7134[0]/irq[10,4298210983]: r=3D0x20 s=3D0x00 PE
>> saa7134[0]/irq: looping -- clearing PE (parity error!) enable bit
>> saa7134[0]: registered device video0 [v4l2]
>> saa7134[0]: registered device vbi0
>>
>> After that the card is working.
>>
>> So something goes wrong with detection. One funny thing: If repeating
>> steps from above, the rev=3D line changes: See:
>>
>> tuner 2-0060: microtune: companycode=3D3cbf part=3D42 rev=3D88
>>
>>
>> [3.] Keywords (i.e., modules, networking, kernel):
>>
>> saa7134; Multimedia
>>
>>
>> [4.] Kernel version (from /proc/version):
>>
>> Linux version 2.6.15-suspend2-r5 (root@amd64) (gcc-Version 4.0.2 (Gent=
oo
>> 4.0.2-r3, pie-8.7.8)) #5 PREEMPT Wed Feb 8 17:59:21 CET 2006
>>
>> Same with vanilla-sources (2.6.15.3) and 2.6.16_rc2-git
>>
>>
>> [5.] Most recent kernel version which did not have the bug:
>>
>> I am not sure, but I think it was version 2.6.14.x
>>
>>
>> [6.] Output of Oops.. message (if applicable) with symbolic informatio=
n
>>      resolved (see Documentation/oops-tracing.txt)
>>
>> No Oopses
>>
>>
>> [7.] A small shell script or example program which triggers the
>>      problem (if possible)
>>
>> Only the modprobe/rmmod stuff from above
>>
>>
>> [8.] Environment
>>
>> Gentoo Base System version 1.12.0_pre15
>> Portage 2.1_pre4-r1 (default-linux/amd64/2005.1, gcc-4.0.2,
>> glibc-2.3.6-r2, 2.6.15-suspend2-r5 x86_64)
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> System uname: 2.6.15-suspend2-r5 x86_64 AMD Athlon(tm) 64 Processor 32=
00+
>> ccache version 2.4 [enabled]
>> dev-lang/python:     2.4.2-r1
>> sys-apps/sandbox:    1.2.17
>> sys-devel/autoconf:  2.13, 2.59-r7
>> sys-devel/automake:  1.4_p6, 1.5, 1.6.3, 1.7.9-r1, 1.8.5-r3, 1.9.6-r1
>> sys-devel/binutils:  2.16.1-r1
>> sys-devel/libtool:   1.5.22
>> virtual/os-headers:  2.6.11-r3
>> ACCEPT_KEYWORDS=3D"amd64 ~amd64"
>> ACCEPT_LICENSE=3D""
>> ALSA_CARDS=3D"intel8x0 emu10k1"
>> ANT_HOME=3D"/usr/share/ant-core"
>> ARCH=3D"amd64"
>> AUTOCLEAN=3D"yes"
>> BASH_ENV=3D"/etc/spork/is/not/valid/profile.env"
>> CBUILD=3D"x86_64-pc-linux-gnu"
>> CCACHE_SIZE=3D"5G"
>> CDEFINE_amd64=3D"__x86_64__"
>> CDEFINE_x86=3D"__i386__"
>> CFLAGS=3D"-O2 -march=3Dathlon64 -pipe"
>> CFLAGS_x86=3D"-m32 -L/emul/linux/x86/lib -L/emul/linux/x86/usr/lib"
>> CHOST=3D"x86_64-pc-linux-gnu"
>> CHOST_amd64=3D"x86_64-pc-linux-gnu"
>> CHOST_x86=3D"i686-pc-linux-gnu"
>> CLASSPATH=3D"."
>> CLEAN_DELAY=3D"5"
>> CONFIG_PROTECT=3D"/etc /usr/kde/2/share/config /usr/kde/3/share/config=

>> /usr/share/X11/xkb /usr/share/config /var/bind /var/qmail/control"
>> CONFIG_PROTECT_MASK=3D"/etc/gconf /etc/splash /etc/terminfo
>> /etc/texmf/web2c /etc/env.d"
>> CVS_RSH=3D"ssh"
>> CXXFLAGS=3D"-O2 -march=3Dathlon64 -pipe"
>> DCCC_PATH=3D"/usr/lib/distcc/bin"
>> DEFAULT_ABI=3D"amd64"
>> DISPLAY=3D":0.0"
>> DISTCC_LOG=3D""
>> DISTCC_VERBOSE=3D"0"
>> DISTDIR=3D"/usr/portage/distfiles"
>> EDITOR=3D"/usr/bin/vim"
>> ELIBC=3D"glibc"
>> EMERGE_WARNING_DELAY=3D"10"
>> FEATURES=3D"autoconfig ccache digest distlocks prelink sandbox sfperms=
 strict"
>> FETCHCOMMAND=3D"/usr/bin/wget -t 5 --passive-ftp --no-check-certificat=
e
>> ${URI} -P ${DISTDIR}"
>> FLTK_DOCDIR=3D"/usr/share/doc/fltk-1.1.7/html"
>> FRITZCAPI_CARDS=3D"fcusb2"
>> GCC_SPECS=3D""
>> GDK_USE_XFT=3D"1"
>> GDM_LANG=3D"de_DE.utf8"
>> GENTOO_MIRRORS=3D"http://ftp-stud.fht-esslingen.de/pub/Mirrors/gentoo/=

>> ftp://gentoo.inode.at/source/ ftp://ftp.easynet.nl/mirror/gentoo/
>> ftp://sunsite.informatik.rwth-aachen.de/pub/Linux/gentoo"
>> GUILE_LOAD_PATH=3D"/usr/share/guile/1.6"
>> G_BROKEN_FILENAMES=3D"1"
>> HISTCONTROL=3D"ignoredups:erasedups"
>> HOME=3D"/root"
>> HOSTNAME=3D"amd64"
>> INFOPATH=3D"/usr/share/info:/usr/share/binutils-data/x86_64-pc-linux-g=
nu/2.16.1/info:/usr/share/gcc-data/x86_64-pc-linux-gnu/4.0.2/info"
>> INPUT_DEVICES=3D"evdev keyboard mouse "
>> JAVAC=3D"/opt/blackdown-jdk-1.4.2.03/bin/javac"
>> JAVA_HOME=3D"/opt/blackdown-jdk-1.4.2.03"
>> JDK_HOME=3D"/opt/blackdown-jdk-1.4.2.03"
>> KERNEL=3D"linux"
>> LADSPA_PATH=3D"/usr/lib64/ladspa"
>> LANG=3D"de_DE.utf8"
>> LC_ALL=3D"de_DE.utf8"
>> LDFLAGS_x86=3D"-m elf_i386 -L/emul/linux/x86/lib -L/emul/linux/x86/usr=
/lib"
>> LESS=3D"-R -M --shift 5"
>> LESSCHARSET=3D"utf-8"
>> LESSOPEN=3D"|lesspipe.sh %s"
>> LIBDIR_amd64=3D"lib64"
>> LIBDIR_x86=3D"lib32"
>> LINGUAS=3D"de"
>> LOGNAME=3D"root"
>> LS_COLORS=3D"no=3D00:fi=3D00:di=3D01;34:ln=3D01;36:pi=3D40;33:so=3D01;=
35:do=3D01;35:bd=3D40;33;01:cd=3D40;33;01:or=3D01;05;37;41:mi=3D01;05;37;=
41:su=3D37;41:sg=3D30;43:tw=3D30;42:ow=3D34;42:st=3D37;44:ex=3D01;32:*.ta=
r=3D01;31:*.tgz=3D01;31:*.arj=3D01;31:*.taz=3D01;31:*.lzh=3D01;31:*.zip=3D=
01;31:*.z=3D01;31:*.Z=3D01;31:*.gz=3D01;31:*.bz2=3D01;31:*.bz=3D01;31:*.t=
bz2=3D01;31:*.tz=3D01;31:*.deb=3D01;31:*.rpm=3D01;31:*.jar=3D01;31:*.rar=3D=
01;31:*.ace=3D01;31:*.zoo=3D01;31:*.cpio=3D01;31:*.7z=3D01;31:*.rz=3D01;3=
1:*.jpg=3D01;35:*.jpeg=3D01;35:*.gif=3D01;35:*.bmp=3D01;35:*.pbm=3D01;35:=
*.pgm=3D01;35:*.ppm=3D01;35:*.tga=3D01;35:*.xbm=3D01;35:*.xpm=3D01;35:*.t=
if=3D01;35:*.tiff=3D01;35:*.png=3D01;35:*.mng=3D01;35:*.pcx=3D01;35:*.mov=
=3D01;35:*.mpg=3D01;35:*.mpeg=3D01;35:*.m2v=3D01;35:*.mkv=3D01;35:*.ogm=3D=
01;35:*.mp4=3D01;35:*.m4v=3D01;35:*.mp4v=3D01;35:*.qt=3D01;35:*.wmv=3D01;=
35:*.asf=3D01;35:*.rm=3D01;35:*.rmvb=3D01;35:*.flc=3D01;35:*.avi=3D01;35:=
*.fli=3D01;35:*.gl=3D01;35:*.dl=3D01;35:*.xcf=3D01;35:*.xwd=3D01;35:*.pdf=
=3D00;32:*.ps=3D00;32:*.txt=3D00;32:*.patch=3D00;32:*.diff=3D00;32:*.log=3D=
00;32:*.tex=3D00;32:*.doc=3D00;32:*.flac=3D01;35:*.mp3=3D01;3

5:*
>> .mpc=3D00;36:*.ogg=3D00;36:*.wav=3D00;36:*.mid=3D00;36:*.midi=3D00;36:=
*.au=3D00;36:*.flac=3D00;36:*.aac=3D00;36:"
>> MAKEOPTS=3D"-j3"
>> MANPATH=3D"/usr/local/share/man:/usr/share/man:/usr/share/binutils-dat=
a/x86_64-pc-linux-gnu/2.16.1/man:/usr/share/gcc-data/x86_64-pc-linux-gnu/=
4.0.2/man::/opt/blackdown-jdk-1.4.2.03/man"
>> MULTILIB_ABIS=3D"x86 amd64"
>> MULTILIB_STRICT_DENY=3D"64-bit.*shared object"
>> MULTILIB_STRICT_DIRS=3D"/lib /usr/lib /usr/kde/*/lib /usr/qt/*/lib
>> /usr/X11R6/lib"
>> MULTILIB_STRICT_EXEMPT=3D"(perl5|gcc|gcc-lib|eclipse-3|debug|portage)"=

>> OPENGL_PROFILE=3D"nvidia"
>> PAGER=3D"/usr/bin/less"
>> PATH=3D"/root/bin:/usr/lib/ccache/bin:/usr/local/sbin:/usr/local/bin:/=
usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.=
0.2:/opt/Acrobat7:/opt/blackdown-jdk-1.4.2.03/bin:/opt/blackdown-jdk-1.4.=
2.03/jre/bin"
>> PKGDIR=3D"/usr/portage/packages"
>> PORTAGE_ARCHLIST=3D"ppc s390 amd64 ppc64 m68k arm sparc sh mips ia64 a=
lpha
>> ppc-macos hppa x86"
>> PORTAGE_BINHOST_CHUNKSIZE=3D"3000"
>> PORTAGE_CALLER=3D"emerge"
>> PORTAGE_ELOG_CLASSES=3D"info warn error log"
>> PORTAGE_ELOG_MAILURI=3D"root@localhost localhost"
>> PORTAGE_ELOG_SYSTEM=3D"save mail"
>> PORTAGE_GID=3D"250"
>> PORTAGE_MASTER_PID=3D"15131"
>> PORTAGE_TMPDIR=3D"/var/tmp"
>> PORTAGE_TMPFS=3D"/dev/shm"
>> PORTDIR=3D"/usr/portage"
>> PORTDIR_OVERLAY=3D"/usr/local/overlays/portage"
>> PRELINK_PATH=3D""
>> PRELINK_PATH_MASK=3D"/usr/lib/gstreamer-0.8:/lib/modules:/usr/lib64/lo=
cale:/usr/lib64/wine:/usr/lib64/valgrind:*.la:*.png:*.py:*.pl:*.pm:*.sh:*=
=2Exml:*.xslt:*.a:*.js:/usr/lib/klibc"
>> PWD=3D"/root"
>> PYTHONDOCS=3D"/usr/share/doc/python-docs-2.4.2/html"
>> PYTHONPATH=3D"/usr/lib/portage/pym"
>> QTDIR=3D"/emul/linux/x86/usr/qt/2:/emul/linux/x86/usr/qt/3"
>> RESUMECOMMAND=3D"/usr/bin/wget -c -t 5 --passive-ftp
>> --no-check-certificate ${URI} -P ${DISTDIR}"
>> RPMDIR=3D"/usr/portage/rpm"
>> RSYNC_RETRIES=3D"3"
>> RSYNC_TIMEOUT=3D"180"
>> SANE_CONFIG_DIR=3D"/etc/sane.d"
>> SHELL=3D"/bin/bash"
>> SHLVL=3D"1"
>> SYMLINK_LIB=3D"yes"
>> SYNC=3D"rsync://rsync.europe.gentoo.org/gentoo-portage"
>> TERM=3D"xterm"
>> USE=3D"amd64 X X509 a52 aac aalib acl acpi acpi4linux activefilter als=
a
>> apache2 avi bash-completion bcmath berkdb bigger-fonts bitmap-fonts
>> bluetooth browserplugin bzip2 bzlib cairo caps cddb cdparanoia cdr
>> chroot client codecs crypt cscope css ctype cups dbm dbus dga dhcp
>> directfb dlloader doc dri dts dvd dvdr dvdread dxr3 eds emboss encode
>> esd exif expat extensions faac faad fame fax faxonly fbcon fbsplash
>> ffmpeg firefox flac font-server foomaticdb freetype fuse gd gdbm gif
>> gimp gimpprint glitz glut gmp gnome gphoto2 gpm gstreamer gtk gtk2
>> gtkhtml guile hal hbci howl icq icu idn imagemagick imap imlib ipv6
>> javascript jbig jpeg jpeg2k lcd lcms ldap libcaca libclamav lirc
>> lm_sensors logrotate lzo lzw lzw-tiff mad maildir mailwrapper mbox mca=
l
>> md5sum mikmod mime mjpeg mng
>> motif mp3 mpeg mpeg4 mppe-mppc mysql nautilus ncurses network nls
>> no-old-linux nptl nptlonly nsplugin ntfs nvidia ogg oggvorbis opengl o=
ss
>> pam password pcntl pdflib perl php pic png pnp posix postgres ppds
>> python quicktime readline rtc ruby samba scanner sdl session sftploggi=
ng
>> slang snmp sockets sox speex spell sqlite ssl subversion svg symlink
>> tcltk tcpd tetex theora threads tiff tokenizer truetype truetype-fonts=

>> type1-fonts udev unicode usb userlocales vcd vim-with-x vorbis wma wmf=

>> wxwindows xine xml2 xmms xpm xprint xrandr xscreensaver xsl xv xvid zl=
ib
>> elibc_glibc fritzcapi_cards_fcusb2 input_devices_evdev
>> input_devices_keyboard input_devices_mouse kernel_linux linguas_de
>> userland_GNU video_cards_apm video_cards_v4l video_cards_nvidia
>> video_cards_nv"
>> USER=3D"root"
>> USERLAND=3D"GNU"
>> USE_EXPAND=3D"DVB_CARDS ELIBC FCDSL_CARDS FRITZCAPI_CARDS INPUT_DEVICE=
S
>> KERNEL LINGUAS USERLAND VIDEO_CARDS"
>> USE_EXPAND_HIDDEN=3D""
>> USE_ORDER=3D"env:pkg:conf:defaults"
>> VIDEO_CARDS=3D"apm v4l nvidia nv"
>> XARGS=3D"xargs -r"
>> XAUTHORITY=3D"/root/.xauthVRSTJs"
>> _=3D"/usr/bin/emerge"
>>
>>
>> [8.1.] Software (add the output of the ver_linux script here)
>>
>> If some fields are empty or look unusual you may have an old version.
>> Compare to the current minimal requirements in Documentation/Changes.
>>
>> Linux amd64 2.6.15-suspend2-r5 #5 PREEMPT Wed Feb 8 17:59:21 CET 2006
>> x86_64 AMD Athlon(tm) 64 Processor 3200+ AuthenticAMD GNU/Linux
>>
>> Gnu C                  4.0.2
>> Gnu make               3.80
>> binutils               2.16.1
>> util-linux             2.12r
>> mount                  2.12r
>> module-init-tools      3.2.2
>> e2fsprogs              1.38
>> reiserfsprogs          line
>> reiser4progs           line
>> PPP                    2.4.3
>> nfs-utils              1.0.7
>> Linux C Library        2.3.6
>> Dynamic linker (ldd)   2.3.6
>> Procps                 3.2.6
>> Net-tools              1.60
>> Kbd                    1.12
>> Sh-utils               5.93
>> udev                   084
>> Modules Loaded         tuner saa7134 tda9887 video_buf v4l2_common
>> v4l1_compat ir_kbd_i2c ir_common videodev snd_seq_midi snd_emu10k1_syn=
th
>> snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_oss
>> snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss b1pci b1dma b1 ca=
pi
>> capifs kernelcapi snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus
>> snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep=

>> snd soundcore 8250_pnp 8250 serial_core forcedeth 8139too mii nvidia e=
th1394
>>
>>
>> [8.2.] Processor information (from /proc/cpuinfo):
>>
>> processor       : 0
>> vendor_id       : AuthenticAMD
>> cpu family      : 15
>> model           : 4
>> model name      : AMD Athlon(tm) 64 Processor 3200+
>> stepping        : 8
>> cpu MHz         : 803.924
>> cache size      : 1024 KB
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 1
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=

>> mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
>> 3dnowext 3dnow
>> bogomips        : 1608.88
>> TLB size        : 1024 4K pages
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 40 bits physical, 48 bits virtual
>> power management: ts fid vid ttp
>>
>>
>> [8.3.] Module information (from /proc/modules):
>>
>> tuner 39396 0 - Live 0xffffffff885e0000
>> saa7134 114216 0 - Live 0xffffffff885c3000
>> tda9887 14800 0 - Live 0xffffffff885eb000
>> video_buf 18244 1 saa7134, Live 0xffffffff885bd000
>> v4l2_common 6400 1 saa7134, Live 0xffffffff885ba000
>> v4l1_compat 11140 1 saa7134, Live 0xffffffff885b6000
>> ir_kbd_i2c 7436 1 saa7134, Live 0xffffffff885b3000
>> ir_common 8708 2 saa7134,ir_kbd_i2c, Live 0xffffffff885af000
>> videodev 9280 1 saa7134, Live 0xffffffff885ab000
>> snd_seq_midi 6976 0 - Live 0xffffffff885a8000
>> snd_emu10k1_synth 6656 0 - Live 0xffffffff885a5000
>> snd_emux_synth 33920 1 snd_emu10k1_synth, Live 0xffffffff8859b000
>> snd_seq_virmidi 6144 1 snd_emux_synth, Live 0xffffffff88598000
>> snd_seq_midi_emul 5696 1 snd_emux_synth, Live 0xffffffff88595000
>> snd_seq_oss 30948 0 - Live 0xffffffff8858c000
>> snd_seq_midi_event 6656 3 snd_seq_midi,snd_seq_virmidi,snd_seq_oss, Li=
ve
>> 0xffffffff88589000
>> snd_seq 49240 8
>> snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_=
oss,snd_seq_midi_event,
>> Live 0xffffffff8857b000
>> snd_pcm_oss 39008 0 - Live 0xffffffff88570000
>> snd_mixer_oss 15232 1 snd_pcm_oss, Live 0xffffffff8856b000
>> b1pci 7360 1 - Live 0xffffffff88566000
>> b1dma 13636 1 b1pci, Live 0xffffffff88561000
>> b1 22784 2 b1pci,b1dma, Live 0xffffffff8855a000
>> capi 14640 4 - Live 0xffffffff88555000
>> capifs 4752 2 capi, Live 0xffffffff88552000
>> kernelcapi 46112 4 b1pci,b1dma,b1,capi, Live 0xffffffff88545000
>> snd_emu10k1 112196 2 snd_emu10k1_synth, Live 0xffffffff88528000
>> snd_rawmidi 21920 3 snd_seq_midi,snd_seq_virmidi,snd_emu10k1, Live
>> 0xffffffff88521000
>> snd_ac97_codec 98428 1 snd_emu10k1, Live 0xffffffff88507000
>> snd_ac97_bus 2432 1 snd_ac97_codec, Live 0xffffffff88505000
>> snd_pcm 81932 3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec, Live
>> 0xffffffff884ef000
>> snd_seq_device 7824 7
>> snd_seq_midi,snd_emu10k1_synth,snd_emux_synth,snd_seq_oss,snd_seq,snd_=
emu10k1,snd_rawmidi,
>> Live 0xffffffff884ec000
>> snd_timer 21256 3 snd_seq,snd_emu10k1,snd_pcm, Live 0xffffffff884e5000=

>> snd_page_alloc 8400 2 snd_emu10k1,snd_pcm, Live 0xffffffff884e1000
>> snd_util_mem 3840 2 snd_emux_synth,snd_emu10k1, Live 0xffffffff884df00=
0
>> snd_hwdep 8392 2 snd_emux_synth,snd_emu10k1, Live 0xffffffff884db000
>> snd 53184 15
>> snd_emux_synth,snd_seq_virmidi,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mix=
er_oss,snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_pcm,snd_seq_device,snd_=
timer,snd_hwdep,
>> Live 0xffffffff884cd000
>> soundcore 8480 1 snd, Live 0xffffffff884c9000
>> 8250_pnp 10496 0 - Live 0xffffffff884c5000
>> 8250 20992 1 8250_pnp, Live 0xffffffff884be000
>> serial_core 18176 1 8250, Live 0xffffffff884b8000
>> forcedeth 21956 0 - Live 0xffffffff884b1000
>> 8139too 22976 0 - Live 0xffffffff884aa000
>> mii 4928 1 8139too, Live 0xffffffff884a7000
>> nvidia 4847316 12 - Live 0xffffffff88006000
>> eth1394 17936 0 - Live 0xffffffff88000000
>>
>>
>> [8.4.] Loaded driver and hardware information (/proc/ioports, /proc/io=
mem)
>>
>> 0000-001f : dma1
>> 0020-0021 : pic1
>> 0040-0043 : timer0
>> 0050-0053 : timer1
>> 0060-006f : keyboard
>> 0070-0077 : rtc
>> 0080-008f : dma page reg
>> 00a0-00a1 : pic2
>> 00c0-00df : dma2
>> 00f0-00ff : fpu
>> 0170-0177 : ide1
>> 01f0-01f7 : ide0
>> 02f8-02ff : serial
>> 0376-0376 : ide1
>> 0378-037a : parport0
>> 03c0-03df : vesafb
>> 03f6-03f6 : ide0
>> 03f8-03ff : serial
>> 0480-0487 : pnp 00:08
>> 0810-0815 : ACPI CPU throttle
>> 0970-0977 : 0000:00:0a.0
>>   0970-0977 : sata_nv
>> 09f0-09f7 : 0000:00:0a.0
>>   09f0-09f7 : sata_nv
>> 0b70-0b73 : 0000:00:0a.0
>>   0b70-0b73 : sata_nv
>> 0bf0-0bf3 : 0000:00:0a.0
>>   0bf0-0bf3 : sata_nv
>> 0cf8-0cff : PCI conf1
>> 0d00-0d07 : pnp 00:08
>>   0d00-0d07 : it87-isa
>> 4000-4003 : PM1a_EVT_BLK
>> 4004-4005 : PM1a_CNT_BLK
>> 4008-400b : PM_TMR
>> 401c-401c : PM2_CNT_BLK
>> 4020-4027 : GPE0_BLK
>> 5000-503f : 0000:00:01.1
>>   5000-5007 : nForce2_smbus
>> 5040-507f : 0000:00:01.1
>>   5040-5047 : nForce2_smbus
>> 5080-509f : 0000:00:01.1
>> b000-cfff : PCI Bus #02
>>   b800-b87f : 0000:02:0b.0
>>   bc00-bc1f : 0000:02:09.0
>>     bc00-bc1e : b1pci-bc00
>>   c000-c03f : 0000:02:09.0
>>   c400-c41f : 0000:02:08.0
>>     c400-c41f : EMU10K1
>>   c800-c8ff : 0000:02:07.0
>>     c800-c8ff : 8139too
>>   cc00-cc07 : 0000:02:08.1
>> d000-d07f : 0000:00:0a.0
>>   d000-d07f : sata_nv
>> d400-d40f : 0000:00:0a.0
>>   d400-d40f : sata_nv
>> ec00-ec07 : 0000:00:05.0
>>   ec00-ec07 : forcedeth
>> ffa0-ffaf : 0000:00:08.0
>>   ffa0-ffa7 : ide0
>>   ffa8-ffaf : ide1
>>
>> 00000000-0009fbff : System RAM
>> 0009fc00-0009ffff : reserved
>> 000a0000-000bffff : Video RAM area
>> 000c0000-000c7fff : Video ROM
>> 000f0000-000fffff : System ROM
>> 00100000-3ffbffff : System RAM
>>   00100000-003ceeaa : Kernel code
>>   003ceeab-0051962f : Kernel data
>> 3ffc0000-3ffcffff : ACPI Tables
>> 3ffd0000-3fffffff : ACPI Non-volatile Storage
>> 9a800000-ba7fffff : PCI Bus #01
>>   a0000000-afffffff : 0000:01:00.0
>>     a0000000-afffffff : vesafb
>> c0000000-dfffffff : 0000:00:00.0
>> fa900000-fe9fffff : PCI Bus #01
>>   fc000000-fcffffff : 0000:01:00.0
>>   fd000000-fdffffff : 0000:01:00.0
>>     fd000000-fdffffff : nvidia
>>   fe9e0000-fe9fffff : 0000:01:00.0
>> fea00000-feafffff : PCI Bus #02
>>   feaff000-feaff7ff : 0000:02:0b.0
>>     feaff000-feaff7ff : ohci1394
>>   feaff800-feaffbff : 0000:02:0a.0
>>     feaff800-feaffbff : saa7134[0]
>>   feaffc00-feaffcff : 0000:02:07.0
>>     feaffc00-feaffcff : 8139too
>> febfc000-febfcfff : 0000:00:05.0
>>   febfc000-febfcfff : forcedeth
>> febfd000-febfdfff : 0000:00:02.0
>>   febfd000-febfdfff : ohci_hcd
>> febfe000-febfefff : 0000:00:02.1
>>   febfe000-febfefff : ohci_hcd
>> febffc00-febffcff : 0000:00:02.2
>>   febffc00-febffcff : ehci_hcd
>> fec00000-fec00fff : reserved
>> fee00000-fee00fff : reserved
>> ff7c0000-ffffffff : reserved
>>
>>
>> [8.5.] PCI information ('lspci -vvv' as root)
>>
>> 00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev=
 a1)
>>         Subsystem: ASUSTeK Computer Inc. Unknown device 813f
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0
>>         Region 0: Memory at c0000000 (32-bit, prefetchable) [size=3D51=
2M]
>>         Capabilities: [44] HyperTransport: Slave or Primary Interface
>>                 Command: BaseUnitID=3D0 UnitCnt=3D14 MastHost- DefDir-=
 DUL-
>>                 Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TX=
O-
>> <CRCErr=3D0 IsocEn- LSEn- ExtCTL- 64b-
>>                 Link Config 0: MLWI=3D16bit DwFcIn- MLWO=3D16bit DwFcO=
ut-
>> LWI=3D16bit DwFcInEn- LWO=3D16bit DwFcOutEn-
>>                 Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TX=
O+
>> <CRCErr=3D0 IsocEn- LSEn- ExtCTL- 64b-
>>                 Link Config 1: MLWI=3D8bit DwFcIn- MLWO=3D8bit DwFcOut=
-
>> LWI=3D8bit DwFcInEn- LWO=3D8bit DwFcOutEn-
>>                 Revision ID: 1.03
>>                 Link Frequency 0: 800MHz
>>                 Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
>>                 Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+
>> 500MHz+ 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
>>      Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
>>                 Link Frequency 1: 200MHz
>>                 Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
>>                 Link Frequency Capability 1: 200MHz- 300MHz- 400MHz-
>> 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
>>      Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE-
>> CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
>>                 Prefetchable memory behind bridge Upper: 00-00
>>                 Bus Number: 00
>>         Capabilities: [c0] AGP version 3.0
>>                 Status: RQ=3D32 Iso- ArqSz=3D2 Cal=3D0 SBA+ ITACoh- GA=
RT64-
>> HTrans- 64bit- FW+ AGP3+ Rate=3Dx4,x8
>>                 Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64=
bit- FW+
>> Rate=3Dx8
>>
>> 00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a=
2)
>>         Subsystem: ASUSTeK Computer Inc. Unknown device 813f
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0
>>
>> 00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management
>> (rev a1)
>>         Subsystem: ASUSTeK Computer Inc. Unknown device 813f
>>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Interrupt: pin A routed to IRQ 0
>>         Region 0: I/O ports at 5080 [size=3D32]
>>         Region 4: I/O ports at 5000 [size=3D64]
>>         Region 5: I/O ports at 5040 [size=3D64]
>>         Capabilities: [44] Power Management version 2
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>> 00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1=
)
>> (prog-if 10 [OHCI])
>>         Subsystem: ASUSTeK Computer Inc. Unknown device 813f
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0 (750ns min, 250ns max)
>>         Interrupt: pin A routed to IRQ 19
>>         Region 0: Memory at febfd000 (32-bit, non-prefetchable) [size=3D=
4K]
>>         Capabilities: [44] Power Management version 2
>>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>> 00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1=
)
>> (prog-if 10 [OHCI])
>>         Subsystem: ASUSTeK Computer Inc. Unknown device 813f
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0 (750ns min, 250ns max)
>>         Interrupt: pin B routed to IRQ 16
>>         Region 0: Memory at febfe000 (32-bit, non-prefetchable) [size=3D=
4K]
>>         Capabilities: [44] Power Management version 2
>>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>> 00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0
>> Controller (rev a2) (prog-if 20 [EHCI])
>>         Subsystem: ASUSTeK Computer Inc. Unknown device 813f
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0 (750ns min, 250ns max)
>>         Interrupt: pin C routed to IRQ 18
>>         Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=3D=
256]
>>         Capabilities: [44] Debug port
>>         Capabilities: [80] Power Management version 2
>>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>> 00:05.0 Bridge: nVidia Corporation CK8S Ethernet Controller (rev a2)
>>         Subsystem: ASUSTeK Computer Inc. Unknown device 80a7
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0 (250ns min, 5000ns max)
>>         Interrupt: pin A routed to IRQ 18
>>         Region 0: Memory at febfc000 (32-bit, non-prefetchable) [size=3D=
4K]
>>         Region 1: I/O ports at ec00 [size=3D8]
>>         Capabilities: [44] Power Management version 2
>>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
>> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>> 00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller=

>> (v2.5) (rev a2) (prog-if 8a [Master SecP PriP])
>>         Subsystem: ASUSTeK Computer Inc. Unknown device 813f
>>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0 (750ns min, 250ns max)
>>         Region 4: I/O ports at ffa0 [size=3D16]
>>         Capabilities: [44] Power Management version 2
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>> 00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller
>> (v2.5) (rev a2) (prog-if 85 [Master SecO PriO])
>>         Subsystem: ASUSTeK Computer Inc. Unknown device 813f
>>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0 (750ns min, 250ns max)
>>         Interrupt: pin A routed to IRQ 16
>>         Region 0: I/O ports at 09f0 [size=3D8]
>>         Region 1: I/O ports at 0bf0 [size=3D4]
>>         Region 2: I/O ports at 0970 [size=3D8]
>>         Region 3: I/O ports at 0b70 [size=3D4]
>>         Region 4: I/O ports at d400 [size=3D16]
>>         Region 5: I/O ports at d000 [size=3D128]
>>         Capabilities: [44] Power Management version 2
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>> 00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI
>> Bridge (rev a2) (prog-if 00 [Normal decode])
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAb=
ort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 16
>>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-laten=
cy=3D10
>>         I/O behind bridge: 0000f000-00000fff
>>         Memory behind bridge: fa900000-fe9fffff
>>         Prefetchable memory behind bridge: 9a800000-ba7fffff
>>         Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAb=
ort-
>> <TAbort- <MAbort+ <SERR- <PERR-
>>         BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
>>
>> 00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge=

>> (rev a2) (prog-if 00 [Normal decode])
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR+ <PERR-
>>         Latency: 0
>>         Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-laten=
cy=3D128
>>         I/O behind bridge: 0000b000-0000cfff
>>         Memory behind bridge: fea00000-feafffff
>>         Prefetchable memory behind bridge: fff00000-000fffff
>>         Secondary status: 66MHz- FastB2B+ ParErr+ DEVSEL=3Dmedium >TAb=
ort-
>> <TAbort- <MAbort+ <SERR- <PERR+
>>         BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>>
>> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron=
]
>> HyperTransport Technology Configuration
>>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Capabilities: [80] HyperTransport: Host or Secondary Interface=

>>                 !!! Possibly incomplete decoding
>>                 Command: WarmRst+ DblEnd-
>>                 Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-=

>> <CRCErr=3D0
>>                 Link Config: MLWI=3D16bit MLWO=3D16bit LWI=3D16bit LWO=
=3D16bit
>>                 Revision ID: 1.02
>>
>> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron=
]
>> Address Map
>>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>
>> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron=
]
>> DRAM Controller
>>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>
>> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron=
]
>> Miscellaneous Control
>>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>
>> 01:00.0 VGA compatible controller: nVidia Corporation NV40 [GeForce 68=
00
>> GT] (rev a1) (prog-if 00 [VGA])
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAb=
ort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 248 (1250ns min, 250ns max)
>>         Interrupt: pin A routed to IRQ 20
>>         Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=3D=
16M]
>>         Region 1: Memory at a0000000 (32-bit, prefetchable) [size=3D25=
6M]
>>         Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=3D=
16M]
>>         [virtual] Expansion ROM at fe9e0000 [disabled] [size=3D128K]
>>         Capabilities: [60] Power Management version 2
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>         Capabilities: [44] AGP version 3.0
>>                 Status: RQ=3D256 Iso- ArqSz=3D0 Cal=3D3 SBA+ ITACoh- G=
ART64-
>> HTrans- 64bit- FW+ AGP3+ Rate=3Dx4,x8
>>                 Command: RQ=3D32 ArqSz=3D2 Cal=3D0 SBA+ AGP+ GART64- 6=
4bit-
>> FW+ Rate=3Dx8
>>
>> 02:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>> RTL-8139/8139C/8139C+ (rev 10)
>>         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAb=
ort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64 (8000ns min, 16000ns max)
>>         Interrupt: pin A routed to IRQ 17
>>         Region 0: I/O ports at c800 [size=3D256]
>>         Region 1: Memory at feaffc00 (32-bit, non-prefetchable) [size=3D=
256]
>>         Capabilities: [50] Power Management version 2
>>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
>> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>> 02:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (r=
ev 07)
>>         Subsystem: Creative Labs SBLive! 5.1 Model SB0100
>>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAb=
ort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64 (500ns min, 5000ns max)
>>         Interrupt: pin A routed to IRQ 21
>>         Region 0: I/O ports at c400 [size=3D32]
>>         Capabilities: [dc] Power Management version 1
>>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>> 02:08.1 Input device controller: Creative Labs SB Live! MIDI/Game Port=

>> (rev 07)
>>         Subsystem: Creative Labs Gameport Joystick
>>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAb=
ort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64
>>         Region 0: I/O ports at cc00 [size=3D8]
>>         Capabilities: [dc] Power Management version 1
>>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>> 02:09.0 Network controller: AVM Audiovisuelles MKTG & Computer System
>> GmbH B1 ISDN
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbor=
t-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64
>>         Interrupt: pin A routed to IRQ 22
>>         Region 0: I/O ports at c000 [size=3D64]
>>         Region 1: I/O ports at bc00 [size=3D32]
>>
>> 02:0a.0 Multimedia controller: Philips Semiconductors SAA7134 Video
>> Broadcast Decoder (rev 01)
>>         Subsystem: Pinnacle Systems Inc. Pinnacle PCTV 300i DVB-T + PA=
L
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAb=
ort-
>> <TAbort- <MAbort- >SERR- <PERR+
>>         Latency: 64 (62000ns min, 62000ns max)
>>         Interrupt: pin A routed to IRQ 17
>>         Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=3D=
1K]
>>         Capabilities: [40] Power Management version 1
>>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
>>
>> 02:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
>> Controller (rev 80) (prog-if 10 [OHCI])
>>         Subsystem: ASUSTeK Computer Inc. Unknown device 808a
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAb=
ort-
>> <TAbort- <MAbort- >SERR- <PERR+
>>         Latency: 64 (8000ns max), Cache Line Size 08
>>         Interrupt: pin A routed to IRQ 17
>>         Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=3D=
2K]
>>         Region 1: I/O ports at b800 [size=3D128]
>>         Capabilities: [50] Power Management version 2
>>                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA
>> PME(D0-,D1-,D2+,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>>
>>
>> [8.6.] SCSI information (from /proc/scsi/scsi)
>>
>> Attached devices:
>> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>   Vendor: ATA      Model: SAMSUNG SP1614C  Rev: SW10
>>   Type:   Direct-Access                    ANSI SCSI revision: 05
>>
>>
>> [8.7.] Other information that might be relevant to the problem
>>        (please look in /proc and include all information that you
>>        think to be relevant):
>>
>> Nothing more ;-)
>>
>>
>> [X.] Other notes, patches, fixes, workarounds:
>>
>> The rmmod/modprobe fun from above is a very, very bad workaround.
>>
>> Thanks in advance
>>
>> Christian
>>
>>
> Cheers,=20
> Mauro.
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> --- saa7134-cards.c.orig	2006-02-08 17:58:46.000000000 +0100
> +++ saa7134-cards.c	2006-02-08 18:39:04.000000000 +0100
> @@ -979,7 +979,7 @@
>  		.radio_type     =3D UNSET,
>  		.tuner_addr	=3D ADDR_UNSET,
>  		.radio_addr	=3D ADDR_UNSET,
> -		.tda9887_conf   =3D TDA9887_PRESENT | TDA9887_INTERCARRIER | TDA9887=
_PORT2_ACTIVE,
> +		.tda9887_conf   =3D TDA9887_PRESENT | TDA9887_INTERCARRIER | TDA9887=
_PORT2_INACTIVE,
>  		.inputs         =3D {{
>  			.name =3D name_tv,
>  			.vmux =3D 3,
> @@ -1668,7 +1668,7 @@
>  		.radio_type     =3D UNSET,
>  		.tuner_addr	=3D ADDR_UNSET,
>  		.radio_addr	=3D ADDR_UNSET,
> -		.tda9887_conf   =3D TDA9887_PRESENT | TDA9887_INTERCARRIER | TDA9887=
_PORT2_ACTIVE,
> +		.tda9887_conf   =3D TDA9887_PRESENT | TDA9887_INTERCARRIER | TDA9887=
_PORT2_INACTIVE,
>  		.mpeg           =3D SAA7134_MPEG_DVB,
>  		.inputs         =3D {{
>  			.name =3D name_tv,


--=20
Tel.: 0641-2097252, Mobil: 0171-3611230
PGP: http://www.roessner-net.com/0x6B929997.asc



--------------enigF092EBF6A94DFF5D4ACA73B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD7HMZZzAxnGuSmZcRAul6AKDaApu0OHXSmKSxwaKIVCqiMdqJawCgkf+J
fSWT+Wum22ZH+UrvvVXSUag=
=eoyY
-----END PGP SIGNATURE-----

--------------enigF092EBF6A94DFF5D4ACA73B4--
