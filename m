Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290266AbSAOUOA>; Tue, 15 Jan 2002 15:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290271AbSAOUNv>; Tue, 15 Jan 2002 15:13:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290266AbSAOUNe>; Tue, 15 Jan 2002 15:13:34 -0500
Date: Tue, 15 Jan 2002 15:13:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Marco Colombo <marco@esi.it>
cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
In-Reply-To: <Pine.LNX.4.33.0201151954010.11441-100000@Megathlon.ESI>
Message-ID: <Pine.LNX.3.95.1020115143729.1338A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Marco Colombo wrote:

> On Tue, 15 Jan 2002, Richard B. Johnson wrote:
> 
> > On Tue, 15 Jan 2002, Marco Colombo wrote:
> > 
> > > On 15 Jan 2002, Thomas Duffy wrote:
> > > 
> > > > On Tue, 2002-01-15 at 04:29, Andrew Pimlott wrote:
> > > > 
> > > > > - Building from source is good karma.
> > 
> > [SNIPPED...]
> > 
> > > 
> > > Every distro supplies a package with the source used to build their own
> > > kernel. Just recomplile it.
> > 
> > Really???  Have you ever tried this? RedHat provides a directory
> > of random patches that won't patch regardless of the order in
> > which you attempt patches (based upon date-stamps on patches or
> > date-stamps on files). It's like somebody just copied in some
> > junk, thinking nobody would ever bother.
> 
> Uh?
> 
> # cd /usr/src/linux-2.4
> # make xconfig

[NO, No, NO....]

I'm not talking about making a kernel that will `work` on your
machine. I'm talking about making __the__ kernel that they supplied
with all its modules, etc.

RedHat 7 is a prime example. I put it on a box in the other room.
/usr/src didn't contain ANYTHING after an installation.
However, /usr/include/asm and /usr/include/linux existed, not
as symlinks, but as files that would-have-existed within a
kernel distribution. 

So... I did RPM install for the kernel after I found what was
alleged to have been the kernel. Now I had a /usr/src/linux/..., but
of course not /usr/src/linux-2.2.16-22, the binary kernel supplied.
The stuff in /usr/include was not fixed or changed to sym-links and it was
incompatible with what existed in the kernel. These were 2.2 files
with so much incompatible stuff; a 447,099 byte diff if you are truly
interested.

The usr/src/linux/.config was the .config obtained off from Linus`
tree, not something provided by RedHat so `make oldconfig` would have
made a "standard kernel" like you download from ftp.kernel.org.

Now, looking in /usr/src/redhat/../.., I find some patches that are
impossible to use to patch the kernel to bring it up (or down) to
the configuration used to build the distribution. The default
configuration, before I "installed" the kernel sources was some
empty directories of /usr/src/redhat/BUILD, /usr/src/redhat/RPMS,
/usr/src/redhat/SOURCES, /usr/src/redhat/SPECS, and /usr/src/redhat/SRPMS.
Now there were some patches and other files with no scripts and no
way to actually use them to modify the kernel. I spent hours, putting
them in order, based upon the time/date stamp within the files, not
the file time which was something more or less random. I made a script
and tried, over a period of weeks, to patch the supplied kernel with
the supplied patches. Forget it. If anything in this universe is truly
impossible, then making a Red Hat distribution kernel from the provided
tools, patches, and sources is a definitive example.

Then, to add insult to injury, the 'C' compiler provided would
not create a bootable kernel. It was egcs-2.91.66. To make
a bootable kernel, I had to install gcc-2.96. The list goes on.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


