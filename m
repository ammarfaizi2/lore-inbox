Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUFFJho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUFFJho (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 05:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUFFJho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 05:37:44 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:29372 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263173AbUFFJhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 05:37:42 -0400
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 06 Jun 2004 11:37:41 +0200
Message-ID: <xb7llj1yql6.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Valdis" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:

    >> You don't tell any kernel about that... it is the bootloader
    >> you are talking to. And that one may very well have integrated
    >> kbd support.

    Valdis> So GRUB knows about keyboards, lets you type in the
    Valdis> "init=/bin/bash", it loads the kernel, the kernel launches
    Valdis> init, /bin/bash gets loaded 

If  init can  launch /bin/bash  (actually,  it lauches  getty in  most
setups), why can't it start the userland keyboard driver daemon?

Back  in the  old days  before the  introduction of  /etc/rc.d/, every
daemon was started from by init.


    Valdis> - and /bin/bash can't talk to the keyboard because the
    Valdis> userspace handler hasn't happened.  

As soon as the daemon is  running, /bin/bash can talk to the keyboard.
There is not much concurrency problems here.  The current input system
makes  it possible  for /bin/bash  to start  opening the  keyboard and
waiting for input before the userspace handler is ready.


    Valdis> At that point you're stuck...

I  can't see  how stuck  it is.   And if  you fear  that  the userland
keyboard driver  would crash  (maybe due to  bugs), use  the 'respawn'
option in /etc/inittab.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

