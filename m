Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131347AbRCWTVn>; Fri, 23 Mar 2001 14:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131353AbRCWTVd>; Fri, 23 Mar 2001 14:21:33 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:4577 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S131345AbRCWTUq>;
	Fri, 23 Mar 2001 14:20:46 -0500
Message-Id: <l0313030db6e14fc39405@[192.168.239.101]>
In-Reply-To: <3ABB992F.D898885C@evision-ventures.com>
In-Reply-To: <Pine.LNX.4.30.0103231053020.27155-100000@xirr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 23 Mar 2001 19:19:25 +0000
To: Martin Dalecki <dalecki@evision-ventures.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Rik, is there any way we could get a /proc entry for this, so that one
>> could do something like:
>
>I will respond; NO there is no way for security reasons this is not a
>good idea.

Just out of interest, what information does the OOM score expose that isn't
already available to Joe Random Unprivileged User?  Looking at my 2.4.1
source, nothing.  The badness() function uses the following:

- memory size
- run time
- cpu time
- nice value
- if it's a root process
- (rare) if process has direct hardware access

Apart from the last item, which is rarely encountered, all the above info
is available using 'top' or 'ps' or via the /proc filesystem already, by
any unprivileged user (unless you've make /proc su-access only, in which
case your point is moot anyway).

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


