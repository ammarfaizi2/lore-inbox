Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279449AbRKFOCe>; Tue, 6 Nov 2001 09:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279382AbRKFOCU>; Tue, 6 Nov 2001 09:02:20 -0500
Received: from mercury.is.co.za ([196.4.160.222]:36879 "HELO mercury.is.co.za")
	by vger.kernel.org with SMTP id <S279416AbRKFOB4>;
	Tue, 6 Nov 2001 09:01:56 -0500
Date: Tue, 6 Nov 2001 16:01:37 +0200
From: Hendrik Visage <hvisage@is.co.za>
To: Steve_Boley@Dell.com
Cc: c.pascoe@itee.uq.edu.au, hvisage@is.co.za,
        ext2-devel@lists.sourceforge.net, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com,
        Michael_E_Brown@Dell.com
Subject: Re: another 2.4.12 + aacraid + SuSE failure.
Message-ID: <20011106160137.Y5665@hermwas.is.co.za>
In-Reply-To: <2FE007705F88044F8B2866EB5AB86070012D6292@ausxmrr803.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <2FE007705F88044F8B2866EB5AB86070012D6292@ausxmrr803.aus.amer.dell.com>; from Steve_Boley@Dell.com on Tue, Nov 06, 2001 at 07:56:54AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Attached the versions etc. of the installed software:

On Tue, Nov 06, 2001 at 07:56:54AM -0600, Steve_Boley@Dell.com wrote:
> You are the first person that has reported this issue with anything below
> 2.4.10 kernel.  I'm kicking this over to one of our engineers and hopefully
> we can start coming up with something and figure what the fault is here.
> Here is something that Hendrik has found that might help find an answer.
> Hendrik any luck so far?????  Can you kick back and tell what if anything
> you have updated besides the kernel in the system?
> 
> Using SGL (sorcerer.wox.org) Linux 2.4.13 + patches
> It appears to be only for the ext2 FS's and not for the reiserfs.
> 
> Interesting, if you've compiled in kernel debugging & the SysReq key stuff, 
> and then issue an emergency sync (Alt-SysReq-S) it works to break the ext2
> out of the lock. 
> 
> An strace of a hanging e2fsck, hangs at the opening of the device...
> 
> I'll perhaps have to try the -ac patches then ...
> 
> Hendrik
> 
> -----Original Message-----
> From: Chris Pascoe [mailto:c.pascoe@itee.uq.edu.au]
> Sent: Tuesday, November 06, 2001 7:29 AM
> To: Steve_Boley@exchange.dell.com
> Subject: RE: another 2.4.12 + aacraid + SuSE failure.
> 
> 
> Hi Steve,
> 
> I don't understand what you're trying to tell me - so perhaps you read my
> message wrong.  I know about alan's patches, I've written a fair bit of
> kernel code over the past few years for various reasons, and tracked the
> ac kernels along the way - and do know how to clean the kernel tree
> completely, etc.  I thought we also determined it was a kernel problem a
> while back too.
> 
> The problem _is still there_ in the official RH kernel 2.4.9-13 - based on
> Alan's kernel!!!  It's not fixed by the AC patches at 2.4.9, at least.
> It appeared to be fine, but after a few days of running variants of them,
> it dies just the same as before.
> 
> RH7.1 is supposedly "supported" by Dell; the kernel I am running is an
> errata upgrade for it, so it needs to be fixed back in this kernel version
> - going to "vanilla" 2.4.10 and losing the little support that we have
> isn't an option.  Going to non-redhat kernels also isn't an option if I
> want to run the tested XFS kernel releases on my 3 identical production
> servers too, and expect any support from the XFS guys when there's
> hiccups.
> 
> So, I've got a RH 2.4.9-13 compiled locally now with kdb in it.
> Eventually the machine runs out of memory (it seems) if you leave it
> sitting at the "Checking root filesystem" and I get a traceback of the
> kernel state.  If you break to kdb prior to the crash (i.e.  while the
> machine appears hung), or wait for it to crash you get an extremely
> strange traceback on the fsck.ext2 process - that suggests something in
> the kernel has overwritten something in memory in a bad way.  I just hard
> crashed my machine setting breakpoints to try to figure out what was going
> on / where this overwriting happens, so I can't try any more (it's 11pm
> local time, anyway - I should be sleeping).
> 
> Chris
> 
> On Tue, 6 Nov 2001 Steve_Boley@Dell.com wrote:
> 
> > Found that the problem is kernel oriented in some way.  I went and got
> Alan
> > Cox's patches for the 2.4.10 and applied the latest did a make mrproper
> > which starts completely over and then applied the aacraid patch again and
> > then recompiled and is coming up clean every time now.  RedHat kernels are
> > built and based on Alan Cox's kernel so there is some patch he has in the
> > kernel that is fixing the issues.  So if you go to kernel.org and go to
> > linux and then kernel and then people his folder is alan and he has
> patches
> > for every 2.4 version there is in this folder.  I was experiencing the
> same
> > hangs due to the fact that I have Mandrake 8.1 loaded on the PE2500
> instead
> > of Redhat and it seems to be for now that Suse and Mandrake have the
> problem
> > for sure and I'm not very sure about Debian at this point.
> >
> > -----Original Message-----
> > From: Chris Pascoe [mailto:c.pascoe@itee.uq.edu.au]
> > Sent: Monday, November 05, 2001 8:06 PM
> > To: Steve_Boley@exchange.dell.com
> > Cc: linux-PowerEdge@exchange.dell.com;
> > linux-aacraid-devel@exchange.dell.com
> > Subject: Re: another 2.4.12 + aacraid + SuSE failure.
> >
> >
> > Hi Steve,
> >
> > > Been pounding away on recompiling 2.4.10 on PE2500 with PERC3/DI and was
> > > getting the same hang at CHECKING ROOT FILESYSTEM.
> > [...]
> >
> > I'm now seeing these hangs with the RedHat 2.4.9-13 kernel - 4 consecutive
> > reboots now, it's just hung on but it has been fine before.  I'll power
> > cycle the machine (test box) shortly.  Any further ideas / news on this
> bug?
> >
> > Chris
> >
> >
> > _______________________________________________
> > Linux-PowerEdge mailing list
> > Linux-PowerEdge@dell.com
> > http://lists.us.dell.com/mailman/listinfo/linux-poweredge
> >
> 

--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="installed.txt"

bash:utils:installed:2.05
bin86:devel:installed:0.16.0
binutils:devel:installed:2.11.2
bison:devel:installed:1.28
busybox:utils:installed:0.60.1
bzip2:archive:installed:1.0.1
console-data:utils:installed:1999.08.29
console-tools:utils:installed:0.2.3
dhcp:net:installed:3.0
diffutils:devel:installed:2.7
e2fsprogs:utils:installed:1.25
ed:editors:installed:0.2
exim:mail:installed:3.33
file:utils:installed:3.36
fileutils:utils:installed:4.1
findutils:utils:installed:4.1
flex:devel:installed:2.5.4a
gawk:editors:installed:3.1.0
gcc:devel:installed:2.95.3
gettext:devel:installed:0.10.39
glibc:devel:installed:2.2.4
grep:utils:installed:2.4.2
groff:doc:installed:1.17.2
gzip:archive:installed:1.2.4a
hc-cron:utils:installed:0.14
jed:editors:installed:B0.99-15
less:utils:installed:358
lynx:web:installed:2.8.4
make:devel:installed:3.79.1
man-pages:doc:installed:1.42
man:doc:installed:1.5i2
modutils:utils:installed:2.4.10
mutt:mail:installed:1.3.23
ncurses:devel:installed:5.2
net-tools:net:installed:1.60
parted:utils:installed:1.4.20
patch:devel:installed:2.5.4
pcmcia-cs:utils:installed:3.1.29
ppp:net:installed:2.4.1
procps:utils:installed:2.0.7
readline:devel:installed:4.2
sed:editors:installed:3.02
shadow:utils:installed:4.0.0
slang:devel:installed:1.4.4
sysvinit:utils:installed:2.82
tar:archive:installed:1.13
texinfo:doc:installed:4.0
textutils:utils:installed:2.0
traceroute:net:installed:1.4a12
unzip:archive:installed:5.42
wget:ftp:installed:1.7
zlib:archive:installed:1.1.3
at:utils:installed:3.1.8
dialog:utils:installed:0.9a-20011014
lvm:utils:installed:1.0.1-rc4
nano:editors:installed:1.0.6
lftp:ftp:installed:2.4.6
linux:devel:installed:2.4.13
cpio:archive:installed:2.4.2
lilo:utils:installed:22.1
sh-utils:utils:installed:2.0
netkit-telnet:net:installed:0.17
perl:devel:installed:5.6.1
openssl:net:installed:0.9.6b
xinetd:net:installed:2.3.3
tcp_wrappers:net:installed:7.6
openjade:doc:installed:1.3
linuxdoc-tools:doc:installed:0.9.10
Linux-PAM:utils:installed:0.75
sudo:utils:installed:1.6.3p7
screen:terminal:installed:3.9.10
vim:editors:installed:6.0
sorcery:utils:installed:20011104
bind-tools:net:installed:9.1.3
sysklogd:utils:installed:1.4.1
strace:devel:installed:4.4
openssh:net:installed:2.9.9p2
gdbm:devel:installed:1.8.0
db:devel:installed:3.3.11

--yNb1oOkm5a9FJOVX--
