Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVCGUwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVCGUwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVCGUvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:51:02 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:23224 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261799AbVCGUN1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:27 -0500
Message-ID: <422CB5E3.3070208@drzeus.cx>
Date: Mon, 07 Mar 2005 21:13:23 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Andrew Morton <akpm@osdl.org>, Mark Canter <marcus@vfxcomputing.com>,
       nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
References: <4227085C.7060104@drzeus.cx>	 <29495f1d05030309455a990c5b@mail.gmail.com>	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>	 <1109875926.2908.26.camel@mindpipe>	 <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>	 <1109876978.2908.31.camel@mindpipe>	 <Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>	 <20050303154929.1abd0a62.akpm@osdl.org> <4227ADE7.3080100@drzeus.cx>	 <4228D013.8010307@drzeus.cx> <1110049247.12201.11.camel@mindpipe>
In-Reply-To: <1110049247.12201.11.camel@mindpipe>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>So is there a bug or not?  Mark seems to be the only one affected.
>
>It's important to follow up, because these so-called "ALSA regressions"
>are generating bad press.
>
>Lee
>
>  
>
I can generate the error using the following procedure:

1. Boot in 2.6.10. Remove /etc/asound.conf and store the current mixer
settings.
2. Boot in 2.6.11 and let alsactl restore the mixer.

Provided the machine is powered down between each attempt this gives the
same result. 'Headphone Jack Sense' ends up not muted (which means that
the built-in speakers are dead).

I fail to find where FC saves/restores the mixer settings so I can't
test without it. There are commands in modprobe.conf but asound.conf
still gets updated when I remove these lines. So there must be some more
place[s] where alsactl gets called.

Rgds
Pierre

