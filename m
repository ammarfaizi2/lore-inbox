Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281795AbRLGPXZ>; Fri, 7 Dec 2001 10:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281759AbRLGPXQ>; Fri, 7 Dec 2001 10:23:16 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:61704 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S281795AbRLGPXE>; Fri, 7 Dec 2001 10:23:04 -0500
Date: Fri, 7 Dec 2001 16:22:47 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Rene Rebe <rene.rebe@gmx.net>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@lists.sourceforge.net>
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] /
 ALSA-0.9.0beta[9,10]
In-Reply-To: <200112070609.fB769Eo08508@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0112071617440.2935-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Dec 2001, Richard Gooch wrote:

> Two possibilities:
>
> - the module is trying to register "unknown" twice. The old devfs core
>   was forgiving about this (although it was always a driver bug to
>   attempt to create a duplicate). The new core won't let you do that.
>   Error 17 is EEXIST. Please fix the driver
>
> - something in user-space created the "unknown" inode before the
>   driver could create it. This is a configuration bug.

Option 3:
Turn a user generated entry into a kernel generated one and return 0.
Prepopulating devfs was a valid option so far, you cannot simply change
this during a stable kernel release.

bye, Roman

