Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbVAQW0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbVAQW0G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVAQWZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:25:35 -0500
Received: from holomorphy.com ([66.93.40.71]:64466 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262902AbVAQWTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:19:55 -0500
Date: Mon, 17 Jan 2005 14:19:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050117221951.GB8896@holomorphy.com>
References: <20050114002352.5a038710.akpm@osdl.org> <20050115025810.GF3474@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115025810.GF3474@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 06:58:10PM -0800, William Lee Irwin III wrote:
> No idea what hit me just yet. x86-64 doesn't boot. Still going through
> the various architectures. The same system (including the initrd FPOS
> bullcrap, though, of course, I'm using an initrd built just for this
> kernel) boots various 2.6.x up to 2.6.10-mm1. There are vague indications
> something in/around SCSI and/or initrd's has violently exploded in my face.

With the waiting 10s patch backed out, things seem to be going well:

$ ssh analyticity
Last login: Mon Jan 17 14:03:13 2005 from meromorphy
Linux analyticity 2.6.11-rc1-mm1 #5 SMP Sat Jan 15 01:25:23 PST 2005 sparc64 GNU/Linux
$ uptime
 14:10:55 up 10 min,  7 users,  load average: 0.10, 0.40, 0.31

Now I just have to remember to set up ip route add 192.168.1.0/24 dev
eth3 via 192.168.1.1 instead of just ip route add 192.168.1.0/24 dev
eth3 so I can tftpboot the thing (well, it took all of 10s to figure
out, but it may not next time). Routing changes are painful.


-- wli
