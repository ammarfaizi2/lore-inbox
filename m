Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132005AbRC0Wqs>; Tue, 27 Mar 2001 17:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131733AbRC0Wqh>; Tue, 27 Mar 2001 17:46:37 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28680 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131724AbRC0WqU>; Tue, 27 Mar 2001 17:46:20 -0500
Message-ID: <3AC117E3.7ACDF2CD@transmeta.com>
Date: Tue, 27 Mar 2001 14:44:51 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <200103272238.QAA38706@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> > >
> > > > high-end-disks. Rather the reverse. I'm advocating the SCSI layer not
> > > > hogging a major number, but letting low-level drivers get at _their_
> > > > requests directly.
> > >
> > > A major for 'disk' generically makes total sense. Classing raid controllers
> > > as 'scsi' isnt neccessarily accurate. A major for 'serial ports' would also
> > > solve a lot of misery
> > >
> >
> > But it might also cause just as much misery, specifically because things
> > move around too much.
> 
> That can be handled. It calls for using a volume name or UUID on file
> systems and allowing mount to accept the volume name.
> 
> One way would be to add the volume identifier (whatever it ends up being)
> to the /proc/partitions file. Then mount could search that table for
> the volume name and use the associated device definitions to accomplish
> the mount.
> 

Since when have serial ports had a UUID or volume name?

Seriously, folks, don't look too much at block devices, especially not
block devices that are mounted.  That's the easy -- nay, trivial --
case.  Char devices is where the rubber hits the road.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
