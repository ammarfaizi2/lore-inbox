Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290739AbSARQ7b>; Fri, 18 Jan 2002 11:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290753AbSARQ7Q>; Fri, 18 Jan 2002 11:59:16 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:19467 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290740AbSARQqy>;
	Fri, 18 Jan 2002 11:46:54 -0500
Date: Sat, 12 Jan 2002 05:36:07 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020112053606.B511@toy.ucw.cz>
In-Reply-To: <20020109174637.A1742@thyrsus.com> <Pine.LNX.4.33.0201092325280.31502-100000@sphinx.mythic-beasts.com> <20020109182902.A2804@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020109182902.A2804@thyrsus.com>; from esr@thyrsus.com on Wed, Jan 09, 2002 at 06:29:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > We've been over this already.  No, the configurator user should *not*
> > > have to su at any point before actual kernel installation.  Bad
> > > practice, no doughnut.
> > 
> > Why bad practice?  Anyway, you can:
> > 
> > 	if [ /proc/ -nt /var/run/dmidecode ]; then
> > 		echo We need to run some code as root.
> > 		echo -n Enter root\'s> > 		su -c 'dmidecode > /var/run/dmidecode'
> > 	fi
> > 
> > Which provides at least a way to have your config tool
> > work without having to bloat the initramfs.
> 
> OK.  One more time.
> 
> The autoconfigurator is *not* mean to be run at boot time, or as root.
> 
> It is intended to be run by ordinary users, after system boot time.
> This is so they can configure and experimentally build kernels without
> incurring the "oops..." risks of going root.
> 
> Therefore, the above 'solution' is not acceptable.

Therefore, autoconfigurator is not acceptable. Tada.

You can't go around saying "my autoconfigurator needs this so put it into
kernel". autoconfigurator is not important enough to touch kernel/initrd.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

