Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSAOUmk>; Tue, 15 Jan 2002 15:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290270AbSAOUm1>; Tue, 15 Jan 2002 15:42:27 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:34434 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S290283AbSAOUmM>;
	Tue, 15 Jan 2002 15:42:12 -0500
Message-Id: <m16QaOc-000OVeC@amadeus.home.nl>
Date: Tue, 15 Jan 2002 20:41:26 +0000 (GMT)
From: arjanv@redhat.com
To: root@chaos.analogic.com
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020115143729.1338A-100000@chaos.analogic.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1020115143729.1338A-100000@chaos.analogic.com> you wrote:

Ok I shouldn't but...

> RedHat 7 is a prime example. I put it on a box in the other room.
> /usr/src didn't contain ANYTHING after an installation.
> However, /usr/include/asm and /usr/include/linux existed, not
> as symlinks, but as files that would-have-existed within a
> kernel distribution. 

Exactly and 100% correct. Those are GLIBC headers and have NOTHING to do
with the kerenl.

> So... I did RPM install for the kernel after I found what was

Well you should have installed the kernel-source rpm if you wanted the full
expanded source... we make that one for a reason you know...

> alleged to have been the kernel. Now I had a /usr/src/linux/..., but

> The usr/src/linux/.config was the .config obtained off from Linus`
> tree, not something provided by RedHat so `make oldconfig` would have
> made a "standard kernel" like you download from ftp.kernel.org.

Ehm yes it does if you use the kernel-source RPM, also we ship about a dozen
different configs (differing in cpu type and up/smp mostly), ALL those
.config files are neatly available in the configs/ subdirectory.

> Now, looking in /usr/src/redhat/../.., I find some patches that are
> impossible to use to patch the kernel to bring it up (or down) to
> the configuration used to build the distribution. The default
> configuration, before I "installed" the kernel sources was some
> empty directories of /usr/src/redhat/BUILD, /usr/src/redhat/RPMS,
> /usr/src/redhat/SOURCES, /usr/src/redhat/SPECS, and /usr/src/redhat/SRPMS.
> Now there were some patches and other files with no scripts

Ehm the .spec file is the script!
rpm -bp kernel-2.2.spec to "run" it to create a source, or rpm -bb to make
rpm -i'able rpm binaries files from it.

> and no
> way to actually use them to modify the kernel. I spent hours, putting
> them in order, based upon the time/date stamp within the files, not
> the file time which was something more or less random. I made a script
> and tried, over a period of weeks, to patch the supplied kernel with
> the supplied patches. Forget it. If anything in this universe is truly
> impossible, then making a Red Hat distribution kernel from the provided
> tools, patches, and sources is a definitive example.

Ok now you offend me. I spent quite a bit of time making the .spec file easy
to read, AND we provide a convenient kernel-source rpm which installs
/usr/src/linux (for RHL7.0) or /usr/src/linux-2.4 for 2.4 kernels (7.1/7.2) 
which contains the full source AND all configs we used. AND if you type
"make oldconfig" it picks the one you are currently running. Heck I even put
a (ok partial) description of each patch (in addition to the brief
description in the spec file) for the 7.1 kernel on
http://people.redhat.com/arjanv/patches.html for people who were interested
in why a patch existed.

Now what more would you want ?  

Greetings,
   Arjan van de Ven
   Red Hat Linux kernel maintainer
   
