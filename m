Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbTBQSFD>; Mon, 17 Feb 2003 13:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbTBQSFD>; Mon, 17 Feb 2003 13:05:03 -0500
Received: from brynhild.mtroyal.ab.ca ([142.109.10.24]:43446 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S267268AbTBQSEv>; Mon, 17 Feb 2003 13:04:51 -0500
Date: Mon, 17 Feb 2003 11:14:47 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: David Woodhouse <dwmw2@infradead.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 clings to you like flypaper
In-Reply-To: <1045503270.17498.29.camel@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.51.0302171107300.8008@skuld.mtroyal.ab.ca>
References: <78320000.1045465489@[10.10.2.4]>  <1045482621.29000.40.camel@passion.cambridge.redhat.com>
  <2460000.1045500532@[10.10.2.4]>  <Pine.LNX.4.51.0302171014320.8008@skuld.mtroyal.ab.ca>
 <1045503270.17498.29.camel@passion.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, David Woodhouse wrote:

> On Mon, 2003-02-17 at 17:17, James Bourne wrote:
> > > No, but it remounts the disk read-write after it mounts it read-only.
> > > It can switch from ext2 to ext3 at that point.
> > 
> > This is a function of your distribution.  The
> > init scripts *should* read /etc/fstab after the kernel mounts /
> > ro and then remount / rw with whatever other options are specified.
> 
> No. You can't remount between ext2 and ext3 like you can for ro/rw.
> You'd have to unmount it completely and remount it.

Right, you can't specify a new FS when remounting.

Looking at the RH rc.sysinit script it doesn't check for
FS type, therefore whatever the kernel believes the FS to be on boot is
what you'll be mounted as when you're running...

Regards
James

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."

