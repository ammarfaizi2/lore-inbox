Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbUFFMHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUFFMHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUFFMHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:07:13 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:9857 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S263366AbUFFMHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:07:10 -0400
Date: Sun, 6 Jun 2004 14:07:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040606120718.GA3667@ucw.cz>
References: <xb7llj1yql6.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7llj1yql6.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 11:37:41AM +0200, Sau Dan Lee wrote:
> >>>>> "Valdis" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:
> 
>     >> You don't tell any kernel about that... it is the bootloader
>     >> you are talking to. And that one may very well have integrated
>     >> kbd support.
> 
>     Valdis> So GRUB knows about keyboards, lets you type in the
>     Valdis> "init=/bin/bash", it loads the kernel, the kernel launches
>     Valdis> init, /bin/bash gets loaded 
> 
> If  init can  launch /bin/bash  (actually,  it lauches  getty in  most
> setups), why can't it start the userland keyboard driver daemon?
> 
> Back  in the  old days  before the  introduction of  /etc/rc.d/, every
> daemon was started from by init.

At the risk of being flamed, here is an explanation.

If you, at the kernel command line, type "init=/bin/bash", the bash
shell will be used _instead_ of the regular init program. This is very
useful when you made a mistake in the inittab, something deleted your
root entry in passwd/shadow, your filesystem is in trouble and in many
other cases.

This also means that there will be no other program run before or after
bash. All you get is a prompt.

This means the keyboard will have to work without any setup - or you
won't be able to type in anything, like a command to run the daemon, or
a command to insert a module.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
