Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUFFPJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUFFPJb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 11:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbUFFPJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 11:09:31 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:3245 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263733AbUFFPJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 11:09:27 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Date: Sun, 6 Jun 2004 10:09:23 -0500
User-Agent: KMail/1.6.2
Cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>, Valdis.Kletnieks@vt.edu
References: <xb7llj1yql6.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7llj1yql6.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200406061009.23831.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 June 2004 04:37 am, Sau Dan Lee wrote:
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

Init does not start bash, in the case above bash started by the kernel
_instead_ of init. The only thing you have is bash. No regular init scripts
will be executed, nothing.
 
 > Back  in the  old days  before the  introduction of  /etc/rc.d/, every
> daemon was started from by init.
> 
> 
>     Valdis> - and /bin/bash can't talk to the keyboard because the
>     Valdis> userspace handler hasn't happened.  
> 
> As soon as the daemon is  running, /bin/bash can talk to the keyboard.

But nothing has started driver (no scriprs were run, remember?) so it's not
running and bash can't get keyboard input.
 
-- 
Dmitry
