Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131813AbRAAPay>; Mon, 1 Jan 2001 10:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131873AbRAAPao>; Mon, 1 Jan 2001 10:30:44 -0500
Received: from mack.rt66.com ([198.59.162.1]:23026 "EHLO Rt66.com")
	by vger.kernel.org with ESMTP id <S131813AbRAAPaj>;
	Mon, 1 Jan 2001 10:30:39 -0500
Message-Id: <l03130301b6764b9a9c4f@[192.168.239.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 1 Jan 2001 07:59:12 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromatix@cyberspace.org>
Subject: Re: path MTU bug still there?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000, Alan Cox wrote:

> > How is this solved? Personally, I am behind a CIPE tunnel with an MTU of
> > 1442 or something like that. I experienced problems to some places and
>
> You have to get the other end to fix it.
>
> > Could it be some kind of incompability at the tunnel level that make you
> > unable to receive large packets over the tunnel? Have you tcpdump:ed to
> > see if the tunnel packets actually make it the way they should?
>
> Its normally seriously incompetent firewall admins on remote sites. Most
>large
> ecommerce sites have these kind of basic errors. Makes you glad to trust your
> credit card details to them doesnt it 8)

In the past few days I encountered an MTU problem on the Internet - some
incompetent admin seemed to have set a low MTU on their router *and* prevented
"can't fragment" messages from being sent from it.  The result was my SSH
tunnel
kept stalling when the route happened to use that particular router.  I fixed
the problem by lowering the MTU on my dial-up PPP connection.

I have also had problems with stalling connections under other circumstances,
but I don't think the kernel or MTU are responsible - yet!

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a19 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
