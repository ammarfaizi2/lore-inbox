Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271065AbTG1VF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271034AbTG1VFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:05:08 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:38540
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S270977AbTG1Upy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:45:54 -0400
Message-ID: <21265.216.12.38.216.1059425148.squirrel@www.ghz.cc>
In-Reply-To: <Pine.LNX.4.53.0307281619060.27642@chaos>
References: <Pine.LNX.4.53.0307281555400.27569@chaos>
    <1059422724VQM.fvw@tracks.var.cx>
    <Pine.LNX.4.53.0307281619060.27642@chaos>
Date: Mon, 28 Jul 2003 16:45:48 -0400 (EDT)
Subject: Re: Turning off automatic screen clanking
From: "Charles Lepple" <clepple@ghz.cc>
To: root@chaos.analogic.com
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson said:
<snip>
> It is impossible to send escape sequences to an input that does
> not exist. That's why I need to know how to stop the kernel's
> insistence on turning off the screen.

from 'strace setterm -blank 0':

   write(1, "\33[9;0]", 6)                 = 6

which means you want to write the escape sequence to standard output (fd
1), or /dev/tty0 if your code is not attached to the current console. This
should be independent of any input devices that may or may not be there.

-- 
Charles Lepple <ghz.cc!clepple>
http://www.ghz.cc/charles/
