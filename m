Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbQLOP2m>; Fri, 15 Dec 2000 10:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133063AbQLOP2X>; Fri, 15 Dec 2000 10:28:23 -0500
Received: from relay.planetinternet.be ([194.119.232.24]:35087 "EHLO
	relay.planetinternet.be") by vger.kernel.org with ESMTP
	id <S130386AbQLOP2O>; Fri, 15 Dec 2000 10:28:14 -0500
Date: Fri, 15 Dec 2000 15:57:42 +0100
From: Kurt Roeckx <Q@ping.be>
To: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
Message-ID: <20001215155741.B4830@ping.be>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com> <91bnoc$vij$2@enterprise.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <91bnoc$vij$2@enterprise.cistron.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 12:14:04AM +0000, Miquel van Smoorenburg wrote:
> In article <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com>,
> LA Walsh <law@sgi.com> wrote:
> >Which works because in a normal compile environment they have /usr/include
> >in their include path and /usr/include/linux points to the directory
> >under /usr/src/linux/include.
> 
> No, that a redhat-ism.
> 
> Sane distributions simply include a known good copy of
> /usr/src/linux/include/{asm,linux} verbatim in their libc6-dev package.

The glibc FAQ still has this in it:

2.17.   I have /usr/include/net and /usr/include/scsi as symlinks
        into my Linux source tree.  Is that wrong?

{PB} This was necessary for libc5, but is not correct when using glibc.
Including the kernel header files directly in user programs usually does not
work (see question 3.5).  glibc provides its own <net/*> and <scsi/*> header
files to replace them, and you may have to remove any symlink that you have
in place before you install glibc.  However, /usr/include/asm and
/usr/include/linux should remain as they were.


It's the version that's in cvs, I just did an cvs update.  It's
been in it for ages.  If it's wrong, someone *please* correct it.


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
