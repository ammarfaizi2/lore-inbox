Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132316AbRDCRFu>; Tue, 3 Apr 2001 13:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRDCRFk>; Tue, 3 Apr 2001 13:05:40 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:51724 "HELO
	mail12.speakeasy.net") by vger.kernel.org with SMTP
	id <S132316AbRDCRF2>; Tue, 3 Apr 2001 13:05:28 -0400
Message-ID: <3AC9F4E0.1A5E637F@megapathdsl.net>
Date: Tue, 03 Apr 2001 09:05:52 -0700
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac28 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Tom Leete <tleete@mountain.net>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Lang <dlang@diginsite.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, lm@bitmover.com,
        linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.4.30.0104021808040.29801-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Mon, 2 Apr 2001, Tom Leete wrote:
> 
> > Oliver Xymoron wrote:
> > >
> > > On Sun, 1 Apr 2001, Jeff Garzik wrote:
> > >
> > > > On Sun, 1 Apr 2001, David Lang wrote:
> > > > > if we want to get the .config as part of the report then we need to make
> > > > > it part of the kernel in some standard way (the old /proc/config flamewar)
> > > > > it's difficult enough sometimes for the sysadmin of a box to know what
> > > > > kernel is running on it, let alone a bug reporting script.
> > > >
> > > > Let's hope it's not a flamewar, but here goes :)
> > > >
> > > > We -need- .config, but /proc/config seems like pure bloat.
> > >
> > > As a former proponent of /proc/config (I wrote one of the much-debated
> > > patches), I tend to agree. Debian's make-kpkg does the right thing, namely
> > > treating .config the same way it treats System-map, putting it in the
> > > package and eventually installing it in /boot/config-x.y.z. If Redhat's
> > > kernel-install script did the same it would rapidly become a non-issue.
> >
> > How about /lib/modules/$(uname -r)/build/.config ? It's already there.
> 
> It'd be great if we got away from the config being hidden too.

How about adding a config tag that gets spit out along an OOPS
message.  We could add a flag to ksymoops that would cause that
flag to be read and the corresponding .config info to get looked
up (mechanism to be determined).  This might reduce the chances
of "new kernel tester" reporting an OOPS but sending in the 
wrong .config data.

	Miles
