Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135240AbRAZLlT>; Fri, 26 Jan 2001 06:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135406AbRAZLlJ>; Fri, 26 Jan 2001 06:41:09 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:32408 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S135240AbRAZLkz>; Fri, 26 Jan 2001 06:40:55 -0500
Date: Fri, 26 Jan 2001 11:40:36 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "David S. Miller" <davem@redhat.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <14961.24658.319734.448248@pizda.ninka.net>
Message-ID: <Pine.SOL.4.21.0101261139150.15526-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, David S. Miller wrote:

> 
> Matti Aarnio writes:
>  >   But could you nevertheless consider supplying a socket option for it ?
>  >   By all means default it per sysctl, but allow clearing/setting by
>  >   program too.
> 
> No, because then people will do the wrong thing.
> 
> They will create intricate "ECN black lists" and make
> their apps set the socket option based upon whether
> a site is in the black list or not.
> 
> This is wrong, and allows the problematic sites to continue to be
> delinquent.
> 
> If these sites gradually become more and more disconnected from
> the rest of the internet, they will fix their kit.  Other schemes
> so far have been met with reluctance on the part of these sites.
> 
> I do not want to condone mechanisms which allow people to make
> crutches for these broken sites ad infinitum.

A delayed retry without ECN might be a good compromise...

Every single connection to ECN-broken sites would work as normal - it
would just take an extra few seconds. Instead of "Hotmail doesn't
work!" it becomes "Hrm... Hotmail is fscking slow, but Yahoo is fine. I'll
use Yahoo". A few million of those, and suddenly Hotmail isn't so hot...

James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
