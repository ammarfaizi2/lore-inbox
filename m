Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265080AbUD3GC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUD3GC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 02:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUD3GC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 02:02:29 -0400
Received: from pdbn-d9bb9ef8.pool.mediaWays.net ([217.187.158.248]:21766 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S265080AbUD3GC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 02:02:27 -0400
Date: Fri, 30 Apr 2004 08:01:46 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Timothy Miller <miller@techsource.com>
Cc: Marc Boucher <marc@linuxant.com>, Rik van Riel <riel@redhat.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040430060146.GA10826@citd.de>
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <40911C01.80609@techsource.com> <20040429213246.GA15988@valve.mbsi.ca> <40917DBA.1080308@techsource.com> <6DB1DC9C-9A2B-11D8-B83D-000A95BCAC26@linuxant.com> <4091895A.6040800@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4091895A.6040800@techsource.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You have pointed out an interesting point in another email.  I have to 
> agree that, technically, thunking to BIOS code also taints the kernel, 
> because it, too, is a black box which could corrupt the kernel.  What do 
> others have to say about that?

There is more.

Not executing external code, but trusting external data.

e.g. The symbios(*1)-SCSI-driver only shows devices enabled in its BIOS.
This information is stored in a little NVRAM-chip(*2) and the driver
uses this data, including bus-speed settings and the like.
At least i (had/have*3) trouble with this "feature"!



*1: NCR, Symbios-Logic, LSI-Logic, whatever they are called today
*2: You need anything "bigger" than the 810-model
*3: I'm not sure if i still have trouble with this feature because i
haven't changed the setup in my computer for 3 years, it MAY be that i
still use a workaround for this feature. My next computer won't have
SCSI anymore, so i don't care if i still use a workaround.



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

