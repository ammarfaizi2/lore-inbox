Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287040AbSALOxQ>; Sat, 12 Jan 2002 09:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287029AbSALOxF>; Sat, 12 Jan 2002 09:53:05 -0500
Received: from waikiki.onda.com.br ([200.195.192.7]:957 "HELO
	waikiki.onda.com.br") by vger.kernel.org with SMTP
	id <S287011AbSALOxC>; Sat, 12 Jan 2002 09:53:02 -0500
Reply-To: nada@onda.com.br
From: nada@onda.com.br (Marco Casaroli)
To: linux-kernel@vger.kernel.org
Subject: Re:  Re: 2.4.17 oops - ext2/ext3 fs corruption (?)
Date: Sat, 12 Jan 2002 12:52:57 -200
Message-Id: <3c404dc90cf760.97643772@onda.com.br>
In-Reply-To: <Pine.LNX.4.33.0201120619330.2686-100000@fire.dragonglen.invalid>
X-Authenticated-IP: [200.192.166.240]
X-Mailer: PHPost 1.07 (http://webgadgets.com/phpost/)
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 6 Jan 2002, Daniel Phillips wrote:
> 
> > On January 6, 2002 12:31 am, Eric wrote:
> > > On Sat, 5 Jan 2002, Andrew Morton wrote:
> > > > Eric wrote:
> > > > >
> > > > > I seem to be having a reoccurring problem with my Red Hat 7.2 system
> > > > > running kernel 2.4.17.  Four times now, I have seen the kernel generate an
> > > > > oops.  After the oops, I find that one of file systems is no longer sane.
> > > > > The effect that I see is a Segmentation Fault when things like ls or du
> > > > > some directory (the directory is never the same).  Also, when the system
> > > > > is going down for a reboot, it is unable to umount the file system.  The
> > > > > umount command returns a "bad lseek" error.
> > > >
> > > > Everything here points at failing hardware.  Probably memory errors.
> > > > People say that memtest86 is good at detecting these things.  Another
> > > > way to verify this is to move the same setup onto a different computer...
> > >
> > > I ran memtest86 on the system and let it complete 4 passes before I
> > > stopped it.  It found no errors.  Unfortunately, I do not have another
> > > system available to test this on.  Are there any other diagnostics I can
> > > run to determine if this is truly a hardware problem?
> >
> > This doesn't smell like hardware to me, since your two backtraces are identical:
> 
> In an attempt to try a get more information about what is going on, I
> tried compiling a new kernel with the options CONFIG_DEBUG_KERNEL and
> CONFIG_DEBUG_BUGVERBOSE turned on.  However, this seems to have made
> things worse.  Now, in about 6-12 hours from boot-up, the system will hang
> completely with no information from the kernel on the console.  The only
> way to get out it is to use the reset button on the front of the box.
> 
> Is there anything else I can do to try and determine if this is a kernel
> problem?  Or at least get more information about what is going on?
> 
> Thanks,
> 
> Eric

I had the same problem with ext3fs
The problem was when trying to READ from the partition and not when trying to write. That was interesting.
I copied a lot of files to my ext3 partition (5 gig) and when I tried to copy it back to the other partition(vfat) there were some input-output errors and i got all the data lost, I had to format the ext3 partition and install linux again.
So, the problem does not seem to be hardware problem.
I am traveling now, not in my house, so I can't test it one more time, and when I'll be back probably there will be a fixed kernel, but if not, I'll test it again anyway.

Marco

