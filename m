Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131796AbRCOTcD>; Thu, 15 Mar 2001 14:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131798AbRCOTby>; Thu, 15 Mar 2001 14:31:54 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:21987 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131796AbRCOTbo>; Thu, 15 Mar 2001 14:31:44 -0500
Message-Id: <l0313030eb6d6c75fcbf8@[192.168.239.101]>
In-Reply-To: <15025.3553.176799.382488@robur.slu.se>
In-Reply-To: <Pine.LNX.4.33.0103152137240.1320-100000@duckman.distro.conectiva>
 <15024.53099.41814.716733@robur.slu.se>
 <Pine.LNX.4.33.0103152137240.1320-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 15 Mar 2001 19:30:56 +0000
To: Robert Olsson <Robert.Olsson@data.slu.se>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: How to optimize routing performance
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And we have done experiments with controlling interrupts and running
> the RX at "lower" priority. The idea is take RX-interrupt and immediately
> postponing the RX process to tasklet. The tasklet opens for new RX-ints.
> when its done.  This way dropping now occurs outside the box since and
> dropping becomes very undramatically.

<snip>

> A bit of explanation. Above is output from tulip driver. We are forwarding
> 44079 and we are dropping  49913 packets per second!  This box has
> full BGP. The DoS attack was going on for about 30 minutes BGP survived
> and the box was manageable. Under a heavy attack it still performs well.

Nice.  Any chance of similar functionality finding its' way outside the
Tulip driver, eg. to 3c509 or via-rhine?  I'd find those useful, since one
or two of my Macs appear to be capable of generating pseudo-DoS levels of
traffic under certain circumstances which totally lock a 486 (for the
duration) and heavily load a P166 - even though said Macs "only" have
10baseT Ethernet.

OTOH, proper management of the circumstances under which this flooding
occurs (it's an interaction bug which occurs when the Linux machine ends up
with a zero-sized TCP receive window) would also be rather helpful.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


