Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131342AbRAOUSd>; Mon, 15 Jan 2001 15:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbRAOUSX>; Mon, 15 Jan 2001 15:18:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46607 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131383AbRAOUSO>; Mon, 15 Jan 2001 15:18:14 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Is sendfile all that sexy?
Date: 15 Jan 2001 12:17:59 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <93vltn$kfd$1@cesium.transmeta.com>
In-Reply-To: <93t1q7$49c$1@penguin.transmeta.com> <14947.5703.60574.309140@leda.cam.zeus.com> <20010115173607.S25659@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010115173607.S25659@mea-ext.zmailer.org>
By author:    Matti Aarnio <matti.aarnio@zmailer.org>
In newsgroup: linux.dev.kernel
> 
> 	One thing about 'sendfile' (and likely 'sendpath') is that
> 	current (hammered into running binaries -> unchangeable)
> 	syscalls support only up to 2GB files at 32 bit systems.
> 
> 	Glibc 2.2(9) at RedHat  <sys/sendfile.h>:
> 
> #ifdef __USE_FILE_OFFSET64
> # error "<sendfile.h> cannot be used with _FILE_OFFSET_BITS=64"
> #endif
> 
> 	I do admit that doing  sendfile()  on some extremely large
> 	file is unlikely, but still...
> 

2 GB isn't really that extremely large these days.  This is an
unpleasant limitation.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
