Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285365AbRLSQSB>; Wed, 19 Dec 2001 11:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285363AbRLSQRw>; Wed, 19 Dec 2001 11:17:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17740 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S285362AbRLSQRg>; Wed, 19 Dec 2001 11:17:36 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Christian Koenig <ChristianK.@t-online.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Otto Wyss <otto.wyss@bluewin.ch>, Alexander Viro <viro@math.psu.edu>,
        antirez <antirez@invece.org>, Andreas Dilger <adilger@turbolabs.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        Craig Christophel <merlin@transgeek.com>
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
In-Reply-To: <200112181605.KAA00820@tomcat.admin.navo.hpc.mil>
	<m1r8prwuv7.fsf@frodo.biederman.org> <3C204282.3000504@zytor.com>
	<m1itb3wsld.fsf@frodo.biederman.org> <3C2052C0.2010700@zytor.com>
	<m18zbzwp34.fsf@frodo.biederman.org> <3C205FBC.60307@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Dec 2001 08:57:02 -0700
In-Reply-To: <3C205FBC.60307@zytor.com>
Message-ID: <m1zo4fursh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> >
> >>From the 10,000 foot level it looks like I am pretty safe already
> > except for those BIOS functions that drive the hardware.  For those I
> > need to setup the legacy PIC back to it's default setting, and
> > possibly a few other hardware things.   I wonder just how sensitive
> > the an x86 BIOS really is to changing those things...
> >
> 
> You never know, especially since part of the BIOS might be an external SCSI or
> network card BIOS...

Which just goes to show what a fragile firmware design it is, to have
firmware callbacks doing device I/O.  I think the whole approach of
having firmware callbacks is fundamentally flawed but I'll do my best
to keep it working, for those things that care.  If it works over 50%
of the time I'm happy...

The much more interesting challenge is to get the linux kernel drivers
to shutdown their hardware well enough that they can still drive the
hardware when linux restarts.  And if the hardware can't do that it is
buggy...


Eric
