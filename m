Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUABASR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUABASQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:18:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:58292 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261974AbUABASF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:18:05 -0500
Date: Thu, 1 Jan 2004 18:17:43 -0600
Subject: Re: udev and devfs - The final word
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: Rob Love <rml@ximian.com>, Nathan Conrad <lk@bungled.net>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
To: Tommi Virtanen <tv@tv.debian.net>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <3FF34522.8060106@tv.debian.net>
Message-Id: <15B77182-3CB9-11D8-A498-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.553)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, Dec 31, 2003, at 15:52 US/Central, Tommi Virtanen wrote:
> I think devfs names are accepted as root= arguments, so that's a bit of
> a loss.. with udev, your /dev and your root= are equal only if you
> follow the standard naming.
>
> For root=, I can see how early userspace can move that to userspace.
> But what about swsuspend?
>
> Are there any more kernel options taking file names? I think now would
> be a good time to stop adding more of them :)

"console=" takes driver-supplied names which usually happen to match 
/dev node names. For example, drivers/serial/8250.c names itself 
"ttyS", so "console=ttyS0" will end up going to that driver, regardless 
of the state of /dev.

I'm not saying that's good or bad, but what's the alternative? 
"console=class/tty/ttyS0"?

-- 
Hollis Blanchard
IBM Linux Technology Center

