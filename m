Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbRAZNw6>; Fri, 26 Jan 2001 08:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRAZNwk>; Fri, 26 Jan 2001 08:52:40 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:53486 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S129561AbRAZNwe>;
	Fri, 26 Jan 2001 08:52:34 -0500
Date: Fri, 26 Jan 2001 13:52:22 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "David S. Miller" <davem@redhat.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <14961.25754.449497.640325@pizda.ninka.net>
Message-ID: <Pine.SOL.4.21.0101261351150.11126-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, David S. Miller wrote:

> 
> James Sutherland writes:
>  > A delayed retry without ECN might be a good compromise...
>  > 
>  > Every single connection to ECN-broken sites would work as normal - it
>  > would just take an extra few seconds. Instead of "Hotmail doesn't
>  > work!" it becomes "Hrm... Hotmail is fscking slow, but Yahoo is fine. I'll
>  > use Yahoo". A few million of those, and suddenly Hotmail isn't so hot...
> 
> No, as explained in previous emails, no retry scheme can work.
> 
> Hotmails failing machines, for example, send RST packets back when
> they see ECN.  Ignoring valid TCP RST frames is unacceptable and
> Linux will not do that as long as I am maintaining it.

I was not suggesting ignoring these. OTOH, there is no reason to treat an
RST packet as "go away and never ever send traffic to this host again" -
i.e. trying another TCP connection, this time with ECN disabled, would be
acceptable.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
