Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273729AbRJPIDq>; Tue, 16 Oct 2001 04:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273836AbRJPID2>; Tue, 16 Oct 2001 04:03:28 -0400
Received: from atlas15.dnp.fmph.uniba.sk ([158.195.25.215]:8083 "EHLO
	melkor.dnp.fmph.uniba.sk") by vger.kernel.org with ESMTP
	id <S273729AbRJPIDO>; Tue, 16 Oct 2001 04:03:14 -0400
Date: Tue, 16 Oct 2001 10:03:32 +0200
From: Radovan Garabik <garabik@melkor.dnp.fmph.uniba.sk>
To: Pavel Machek <pavel@suse.cz>
Cc: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] dead keys in unicode console mode
Message-ID: <20011016100332.A8859@melkor.dnp.fmph.uniba.sk>
In-Reply-To: <20011008215313.A11879@melkor.dnp.fmph.uniba.sk> <20011009041618.A6135@win.tue.nl> <20011009092858.A15708@melkor.dnp.fmph.uniba.sk> <20011010171934.D35@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010171934.D35@toy.ucw.cz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 05:19:34PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > And now all existing binaries that use the KDGKBDIACR ioctl
> > > dump core? And all existing binaries that use the KDSKBDIACR
> > > ioctl do very strange things?
> > 
> > well, of course, existing binaries need to be recompiled,
> > that's what sources are for...
> 
> And go to hell when you boot older kernel? 

Uh, why? KDSKBDIACR ioctl checks the size of accent_table array.
(if that is what you have in mind)
All that happens is that diacritics will be messed up with 
older kernel, which is acceptable and to be expected.

> Not an option. Add new ioctl.

As it has been already said, 16-bit unicode console mode has outlived
its usefulness, and we should move to full 32 bit
support. Adding new 16-bit structures is IMHO waste of time.


-- 
 -----------------------------------------------------------
| Radovan Garabik http://melkor.dnp.fmph.uniba.sk/~garabik/ |
| __..--^^^--..__    garabik @ melkor.dnp.fmph.uniba.sk     |
 -----------------------------------------------------------
Antivirus alert: file .signature infected by signature virus.
Hi! I'm a signature virus! Copy me into your signature file to help me spread!
