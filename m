Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUFFQNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUFFQNS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUFFQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:13:18 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:50650 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263776AbUFFQNM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:13:12 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Subject: Re: keyboard problem with 2.6.6
References: <xb7llj1yql6.fsf@savona.informatik.uni-freiburg.de>
	<200406061009.23831.dtor_core@ameritech.net>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 06 Jun 2004 18:13:10 +0200
In-Reply-To: <200406061009.23831.dtor_core@ameritech.net>
Message-ID: <xb7vfi4y8a1.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:

    >>  If init can launch /bin/bash (actually, it lauches getty in
    >> most setups), why can't it start the userland keyboard driver
    >> daemon?
    >> 

    Dmitry> Init does not start bash, in the case above bash started
    Dmitry> by the kernel _instead_ of init. The only thing you have
    Dmitry> is bash. No regular init scripts will be executed,
    Dmitry> nothing.

If you  can launch /bin/bash  using init= from  GRUB or LILO,  you can
equally lauch a bash script  that starts the userspace keyboard driver
daemon before and then "exec /bin/bash".

Of course, you can argue that this daemon may rest on a fs that hasn't
be mounted yet,  or on a fs  that has been corrupted.  But  so can the
/bin/bash executable!

Moreover,  I  can also  argue  the kernel  image  may  also have  been
corrupted due  to disk  errors, and the  keyboard driver code  lies in
those corrupted sectors, unfortunately.



Further, a  kernel keyboard driver  can coexist with a  userspace one.
The  kernel one can  be made  simpler, providing  only the  very basic
needs.   Once the userspace  daemon starts  successfully, it  can take
over.  Programs like  X11 may drive the keyboard  directly and provide
many  sophisticated  features  that  a simple  kernel  driver  doesn't
provide.  Take a look at xkb.


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

