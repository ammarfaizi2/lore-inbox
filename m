Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265119AbSJWRlV>; Wed, 23 Oct 2002 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265122AbSJWRlV>; Wed, 23 Oct 2002 13:41:21 -0400
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:13074 "HELO
	hosting-network.com") by vger.kernel.org with SMTP
	id <S265119AbSJWRlT>; Wed, 23 Oct 2002 13:41:19 -0400
Subject: Re: "Hearty AOL" for kexec
From: Torrey Hoffman <thoffman@arnor.net>
To: root@chaos.analogic.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Roskin <proski@gnu.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1021023132644.14975A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021023132644.14975A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Oct 2002 10:43:07 -0700
Message-Id: <1035394988.30560.102.camel@rivendell.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 10:31, Richard B. Johnson wrote:
> On 23 Oct 2002, Torrey Hoffman wrote:
> 
> > On Wed, 2002-10-23 at 08:03, Eric W. Biederman wrote:
> > > Pavel Roskin <proski@gnu.org> writes:
> > [...]
> > > > I really want to see this feature in the kernel.  It is very useful in
> > > > embedded systems.  Just imagine loading the bootstrap kernel, then
> > > > downloading the new kernel over anything - HDLC, 802.11, USB, decrypting
> > > > it from flash etc.  Possibilities are infinite.
> > > 
> > > Yay!!!!  My first embedded developer who doesn't think it is silly to
> > > use a kernel as a bootloader :)  Or at least the first to admit they
> > > embedded developer.
> > 
> > Yeah, another AOL "Me Too" here - I'm an embedded linux developer and
> > think would be useful.  Being able to network boot the device, download
> > software to a flash, and then directly "kexec" boot from the kernel on
> > the flash would be nice. 
> > 
> > Anything that reduces dependencies on the BIOS is good.  I'd use this
> > feature if it was available.
> 
> But 'downloading' (actually uploading) software and writing it to
> flash for a re-boot is a trivial user-mode task. The actual boot
> from such a virtual disk takes 4 seconds on a real system (AMD SC520)
> processor in an embedded system. You don't need any special kernel
> hooks.

Sure - once I've written the new software into the flash I can just
reboot normally.  That's what I do now, it works, it's simple.  

But on the devices we use, that requires an extra, unnecessary startup
delay of least 15 seconds as the BIOS does all the usual, PC-style
system startup.  And it depends on the BIOS correctly determining that
it should boot from flash instead of the network.

Using "kexec" to go directly from setting up the flash to booting from
it would cut our system startup time in half and reduce BIOS dependency.

Not a big deal, but it would be nice.

Torrey Hoffman
thoffman@arnor.net
torrey.hoffman@myrio.com



