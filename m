Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTKZRel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTKZRel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:34:41 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:14472
	"EHLO diablo.hd.free.fr") by vger.kernel.org with ESMTP
	id S264267AbTKZRej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:34:39 -0500
Message-ID: <3FC4E42A.40906@free.fr>
Date: Wed, 26 Nov 2003 18:34:34 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Wed, 26 Nov 2003, Vince wrote:
> 
> <4>Oops: 0000 [#49]
> 
> At the point you're at there really isn't much state left to work from.
> Any chance you can get at the logs (if it hit disk) and get the first
> oops?
> 

Nothing ever hits the disk (In interrupt handler - not syncing ...), 
that's the reason why I had to install kmsgdump in the first place.
(Sidenote: a few days ago, I had the intent to install the lkcd kernel 
patches, but gave up because of the time required to 
patch/compile/install/setup correctly the kernel and userspace utilities 
(not .deb of lkcd-utils available...)).
I suppose I could enlarge the kernel message log size, but the kmsgdup 
documentation states:
---------------------------------
If you have changed your messages buffer size (which is 16 kB by 
default), you should modify the size in "include/asm/kmsgdump.h", 
parameter LOG_BUF_LEN. Some people required 32 kB. But you shouldn't 
exceed 60 kB since the dump is done in real mode (16 bits).
For kernel versions 2.5.6x and later, the LOG_BUF_LEN parameter is part
of the kernel .config file (LOG_BUF_SHIFT) so you don't need to modify
it at all.
---------------------------------

...so I you think 60kB would be enough to catch the first oops -- or if 
the doc is outdated -- I can try this...

