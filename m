Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129555AbQK3SpE>; Thu, 30 Nov 2000 13:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129595AbQK3Soy>; Thu, 30 Nov 2000 13:44:54 -0500
Received: from Cantor.suse.de ([194.112.123.193]:55826 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S129226AbQK3Soq>;
        Thu, 30 Nov 2000 13:44:46 -0500
Date: Thu, 30 Nov 2000 19:14:14 +0100
From: Andi Kleen <ak@suse.de>
To: Ben Mansell <ben@zeus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP push missing with writev()
Message-ID: <20001130191414.A13814@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.30.0011301710020.8071-100000@artemis.cam.zeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0011301710020.8071-100000@artemis.cam.zeus.com>; from ben@zeus.com on Thu, Nov 30, 2000 at 05:35:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 05:35:41PM +0000, Ben Mansell wrote:
> (possibly treading on ground covered before:
>  http://www.uwsg.iu.edu/hypermail/linux/kernel/9904.1/0304.html )
> 
> To be brief and to the point: Should there be any difference between the
> following two ways of writing data to a TCP socket?
> 
> 1) write( fd, buffer, length )
> 2) writev( fd, {buffer, length}, {NULL,0} )

No.

> 
> The problem is that if data happens to be written via method (2), then
> the PUSH flag is never set on any packets generated. This is a bug,
> surely?

I just tried it on 2.2.17 and 2.4.0test11 and it sets PUSH for writev()
for both cases just fine. Maybe you could supply a test program and tcpdump
logs for what you think is wrong ? 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
