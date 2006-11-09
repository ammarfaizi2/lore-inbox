Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424235AbWKIXEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424235AbWKIXEk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424238AbWKIXEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:04:39 -0500
Received: from mail.gmx.de ([213.165.64.20]:38829 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1424235AbWKIXEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:04:39 -0500
X-Authenticated: #5860531
Date: Fri, 10 Nov 2006 00:04:43 +0100
From: Oliver Brakmann <obrakmann@gmx.net>
To: Jano <jano@90-mo3-3.acn.waw.pl>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Message-ID: <20061109230443.GA4759@news.teleos-web.de>
References: <d9a083460611081309r680a5420sbb6156f5d4240797@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9a083460611081309r680a5420sbb6156f5d4240797@mail.gmail.com>
User-Agent: mutt-ng/devel-r804 (Debian)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ sorry if the CC line isn't intact. I'm reading via Gmane, and though
  they keep the CC line, the To: line just gets turned into the
  newsgroups: line, so I almost never see all recipients :-/ ]

Hi,

On Wed, 2006-11-08 22:09, Jano wrote...
> +Adding 1028120k swap on /dev/hda7.  Priority:-1 extents:1 across:1028120k
> +EXT3 FS on hda3, internal journal

This is S20checkroot.sh running...

> +md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
> +md: bitmap version 4.39

This is S25mdadm-raid.

> +device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
> +device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
> +device-mapper: ioctl: error adding target to table

At this point, it looks like something already grabbed hold of /dev/hdb.
Both evms and lvm get started here, right after S25mdadm-raid.

This is just a hunch, but you might try disabling either of the two.
Also, it might help if you'd post the output of 'fdisk -l /dev/hdb' to
see what's on it.  The output of 'pvs' might help, too.

I have no clue why this error only shows up with the vanilla kernel and
not with the Ubuntu one, though :-/

Bye,
Oliver
-- 
It's practically impossible to look at a   /\   #198843 @ http://counter.li.org
penguin and feel angry.     -- Joe Moore   \/

NP: Apoptygma Berzerk - Until the end of the world
