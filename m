Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269270AbTCBS2e>; Sun, 2 Mar 2003 13:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269273AbTCBS2e>; Sun, 2 Mar 2003 13:28:34 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:44557 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S269270AbTCBS2d>;
	Sun, 2 Mar 2003 13:28:33 -0500
Date: Sun, 2 Mar 2003 19:38:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [Bug 423] New: make -j X bzImage gives a warning
Message-ID: <20030302183857.GA8094@mars.ravnborg.org>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <347860000.1046465385@flay> <20030228212504.GA21843@mars.ravnborg.org> <362820000.1046468331@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <362820000.1046468331@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 01:38:51PM -0800, Martin J. Bligh wrote:
> > On Fri, Feb 28, 2003 at 12:49:45PM -0800, Martin J. Bligh wrote:
> >> http://bugme.osdl.org/show_bug.cgi?id=423
> >> 
> >>            Summary: make -j X bzImage gives a warning
> >>     Kernel Version: 2.5.63
> >>             Status: NEW
> >>           Severity: low	
> >>              Owner: zippel@linux-m68k.org
> >> make -j X bzImage gives a warning:
> >> 
> >> make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make
> >> rule.
> >> 
> >> Can we get rid of this one way or the other?

Kai has fixed this one in bk-latest.

Sample run:

[sam@mars kbuild4]$ make -j2 bzImage
make[1]: `scripts/kconfig/conf' is up to date.
./scripts/kconfig/conf -s arch/i386/Kconfig
#
# using defaults found in .config
#
  SPLIT   include/linux/autoconf.h -> include/config/*
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
  GEN     include/linux/compile.h (unchanged)
Kernel: arch/i386/boot/bzImage is ready

	Sam
