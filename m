Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbUAEFcf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 00:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265888AbUAEFcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 00:32:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12388 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265889AbUAEFc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 00:32:29 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
References: <20040104034934.A3669@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
	<20040104142111.A11279@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
	<20040104230104.A11439@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
	<20040105030737.GA29964@nevyn.them.org>
	<Pine.LNX.4.58.0401041918260.2162@home.osdl.org>
	<20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0401041954010.2162@home.osdl.org>
	<20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2004 22:26:37 -0700
In-Reply-To: <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk>
Message-ID: <m1y8sndkz6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:

> On Sun, Jan 04, 2004 at 08:02:20PM -0800, Linus Torvalds wrote:
> > Now, we'd probably not want to force the switch, but I do suspect we'll 
> > have exactly this as a switch in the "Kernel Debugging Config" section. 
> > Where even _common_ things like disks could end up with per-bootup values. 
> > Just to verify that every part of the system ends up having it right.
> 
> Then we'd better have a very good idea of the things that are going to
> break.  Note that right now even late-boot code in kernel itself will
> break on that - there are explicit checks for ROOT_DEV==MKDEV(2,0),
> all sorts of weird crap deep in the bowels of arch/ppc/*/*, etc.

/sbin/lilo and possibly some of the other bootloaders.  Relationships
between devices are a challenge to work with.  How do you go from a
partition to it's actual block device etc.  I don't remember how many
major numbers lilo has hard coded, I just remember looking at it once
and realizing I couldn't think of a better way to accomplish what it
was trying to do.

Eric

