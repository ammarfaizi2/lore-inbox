Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274597AbRIYKVj>; Tue, 25 Sep 2001 06:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274598AbRIYKV3>; Tue, 25 Sep 2001 06:21:29 -0400
Received: from ms.exp-math.uni-essen.de ([132.252.150.18]:63247 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S274597AbRIYKV0>; Tue, 25 Sep 2001 06:21:26 -0400
Date: Tue, 25 Sep 2001 12:21:47 +0200 (MESZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: "[A]ndy80" <andy80@ptlug.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Burning a CD image slow down my connection
In-Reply-To: <1001412802.1316.4.camel@piccoli>
Message-Id: <Pine.A32.3.95.1010925121523.20872B-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Sep 2001, [A]ndy80 wrote:

> I've my Plextor Writer as secondary master seen as a scsi device and if
> I try do use hdparm it says:
> 
> [root@piccoli shady]# hdparm -t /dev/cdrom
> /dev/cdrom not supported by hdparm

Hmm, /dev/cdrom would typically be a link. You might try to apply hdparm
to where the link points to, but I cannot really believe hdparm doesn't
follow links.

Normally /dev/cdrom should point to /dev/hdc in your case. I somewhat
suspect that it points to /dev/scd0. If so, can you actually
mount the cdrom? The ide2scsi device emulation basically just passes
scsi commands as atapi commands over the ide bus (since atapi just
use the scsi commands but tunnel them over ide). I'm surprised this also
works for cdroms. I wasn't aware of the fact they are ATAPI and thus
support the scsi command set. Maybe the cdwriters are special in that
context.

Anyway, you'll have to point hdparm to the ide device for your
writer/cdrom.

Michael.

--

Michael Weller: eowmob@exp-math..uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.

