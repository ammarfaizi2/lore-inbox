Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316989AbSGCJdI>; Wed, 3 Jul 2002 05:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316991AbSGCJdH>; Wed, 3 Jul 2002 05:33:07 -0400
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:55434 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S316989AbSGCJdH>; Wed, 3 Jul 2002 05:33:07 -0400
Date: Wed, 3 Jul 2002 05:40:31 -0400
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-ID: <20020703094031.GA4462@lnuxlab.ath.cx>
References: <20020703022051.GA2669@lnuxlab.ath.cx> <20020703102244.B2491@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020703102244.B2491@redhat.com>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 10:22:44AM +0100, Stephen C. Tweedie wrote:
> Ugh.  My first guess would be that you have one enormously fragmented
> filesystem.  13MB in 2 minutes?  A modern disk should get that amount
> of data to disk in one second, but massive fragmentation can simply
> kill disk performance.
> 
> If /home is on the same disk, do you get the same problem trying to
> write there?

Yeah, /home/ is on the same disk.  Your guess might be right because
that's what I was trying to show.  When I copy the file, which is in
/home/(hda2) to /tmp/(hda1) and I sync, it takes almost 2 minutes.  But 
if I copy the same file, which is in /home/(hda2) to /usr/local/(hda3),
sync returns immediately.  This disk isn't that old either.

hda: Maxtor 51536U3, ATA DISK drive
hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=1868/255/63,
UDMA(66)

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
