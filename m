Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbQKFWF2>; Mon, 6 Nov 2000 17:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130400AbQKFWFS>; Mon, 6 Nov 2000 17:05:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23307 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129631AbQKFWFA>; Mon, 6 Nov 2000 17:05:00 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: xterm: no available ptys
Date: 6 Nov 2000 14:04:19 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8u79t3$o7a$1@cesium.transmeta.com>
In-Reply-To: <20001106203738.17935.qmail@web110.yahoomail.com> <20001106155755.A4096@munchkin.spectacle-pond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001106155755.A4096@munchkin.spectacle-pond.org>
By author:    Michael Meissner <meissner@spectacle-pond.org>
In newsgroup: linux.dev.kernel
> 
> Did you mount /dev/pts, which is usually done with a line in /etc/fstab:
> 
> none /dev/pts devpts gid=5,mode=0622 0 0
> 

That should be gid=5,mode=0620 unless you *REALLY*, *REALLY* know what
you're doing!!!!  Arguably, that should actually be mode=0600, with
user tty's then being required to chmod to 0620 if they want "mesg y"
by default.

(gid 5 being the gid for group "tty".)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
