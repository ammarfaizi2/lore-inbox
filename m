Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUDCXCM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 18:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUDCXCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 18:02:12 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:61594 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262019AbUDCXCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 18:02:07 -0500
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: 2.6.[45]-.*: weird behavior
Date: Sun, 4 Apr 2004 01:09:13 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200404032122.54823.rjwysocki@sisk.pl> <200404032314.27866.rjwysocki@sisk.pl> <Pine.LNX.4.58.0404032341450.18910@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0404032341450.18910@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404040109.13414.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 of April 2004 00:15, Grzegorz Kulewski wrote:
> On Sat, 3 Apr 2004, R. J. Wysocki wrote:
> > On Saturday 03 of April 2004 21:50, Grzegorz Kulewski wrote:
> > > On Sat, 3 Apr 2004, R. J. Wysocki wrote:
> >
> > [...]
> >
> > > Can you attach config files for both the AMD64 and the laptop?
> >
> > The config for the laptop is attached, the other one must wait.  If you
> > think of what they have in common, there's not much.
>
> Ok, some questions to that config file. Why do you have:
> - scsi emulation
> - scsi
> - both generic ide options
> - large block devices (2TB)?

SCSI support is necessary for USB storage, the rest is just for fun. :-)

> Can you post:
> - distro name and version

RH9

> - dmesg or log at the end of testing - better after such kb lock if you
> can reproduce, maybe after some stressing to see if any unnormal messages
> appeared
> - lspci -v
> - lsmod
> - mount
> - hdparm hdparm -iIvtT for all drives
> - some files from /proc describing configuration if you think they are
> important.

Well, I _really_ had not much time to track this.  If I'd had time, I'd 
probably have checked all these things already.  I don't think there are any 
unusual things about what you list, though.

> Does any process sleep in D state in ps output all the time or bechaves
> strangely? If so, maybe you should find and apply the patch for kernel
> stack for each process in /proc (it was included in wolk for example) and
> check what kernel function is causing the waits (for example I found some
> usb problems causing D state lock of processes using some usb ioctls).

Good idea, I can do that.

> If it all does not help, maybe you should compile kernel with all debug
> and kernel hacking options to see if some driver does not lock the kernel
> and sleep or something like that, or possibly try to find what changeset
> between 2.6.3 and 2.6.4 broke your setup :)

Well, the patch-2.6.4.bz2 is 2.2+M big.  That's _a_ _lot_ of changesets, so I 
don't think I can figure out this, unless I know which one could 
_potentially_ cause the effects that I observe.  Please, give me a hint, if 
you have any idea.

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
