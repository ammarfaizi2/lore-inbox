Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289379AbSAJKgA>; Thu, 10 Jan 2002 05:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289380AbSAJKfv>; Thu, 10 Jan 2002 05:35:51 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:27141 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S289379AbSAJKfd>; Thu, 10 Jan 2002 05:35:33 -0500
Date: Thu, 10 Jan 2002 10:35:31 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <20020109182902.A2804@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201101014560.14207-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Eric S. Raymond wrote:

> > 	if [ /proc/ -nt /var/run/dmidecode ]; then
> > 		echo We need to run some code as root.
> > 		echo -n Enter root\'s\
> > 		su -c 'dmidecode > /var/run/dmidecode'
> > 	fi

> The autoconfigurator is *not* mean to be run at boot time, or as root.

Under normal circumstances.

> It is intended to be run by ordinary users, after system boot time.
> This is so they can configure and experimentally build kernels without
> incurring the "oops..." risks of going root.

Then ship it in a separate package with initscripts.  Either
CML2 is well enough designed that the autoconfigurator will
not need to change as the kernel does, or all your
overengineering was for nought.

> Therefore, the above 'solution' is not acceptable.

To who?  It provides as way for your configurator to function
out-of-the-box until distributions choose whether it's worth
their while to support your scheme.

Matthew.

