Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbQKOJWx>; Wed, 15 Nov 2000 04:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129157AbQKOJWn>; Wed, 15 Nov 2000 04:22:43 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:14095 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129097AbQKOJWW>; Wed, 15 Nov 2000 04:22:22 -0500
Date: Wed, 15 Nov 2000 02:52:13 -0600
To: Zhiruo Cao <zhiruo@cc.gatech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on bdflush
Message-ID: <20001115025213.J18203@wire.cadcamlab.org>
In-Reply-To: <Pine.GSU.4.21.0011141847460.26147-100000@lennon.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSU.4.21.0011141847460.26147-100000@lennon.cc.gatech.edu>; from zhiruo@cc.gatech.edu on Tue, Nov 14, 2000 at 06:52:21PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Zhiruo Cao]
> Why does bdflush (kupdated and kflushed) writes to disk periodically
> even though the system is apparently idle.  I think if no more new
> buffers becomes dirty, kflushed show not write anything to disk.

kill -STOP {your cron process}
mount all ext2 filesystems with '-o noatime' or at least '-o nodiratime'

Lots of other small things can be done to reduce disk access.  I think
you can even 'kill -STOP {kflushd}' (but don't forget to reenable it at
some point).

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
