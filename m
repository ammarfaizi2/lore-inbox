Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTIGWKh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 18:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTIGWKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 18:10:37 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:13576 "EHLO
	mail2.cybertrails.com") by vger.kernel.org with ESMTP
	id S261651AbTIGWKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 18:10:36 -0400
Date: Sun, 7 Sep 2003 15:10:29 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: "Chris Peterson" <chris@potamus.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] "ls -R" freezes when using gnome-terminal on
 linux-2.6.0-test4
Message-Id: <20030907151029.331f5fa4.dickson@permanentmail.com>
In-Reply-To: <001301c3756f$18f847d0$323be90c@bananacabana>
References: <001301c3756f$18f847d0$323be90c@bananacabana>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Sep 2003 11:37:31 -0700, Chris Peterson wrote:

> I have discovered a regression between linux-2.4.20-8 (Redhat 9) and
> linux-2.6.0-test4. I have not tried any other versions of linux-2.6.0-testX
> or 2.5.x.
> 
> How to reproduce the problem:
> 1. Running GNOME on linux-2.6.0-test4, open two gnome-terminals.
> 2. In the first gnome-terminal, run "ls -R /" or "ls -R /dev" (you won't
> have to wait as long :-).
> 3. In the second gnome-terminal, simply run "ls" (or just opening a
> gnome-terminal window will sometimes cause the same problem).
> 
> Actual Results:
> The ls in the first gnome-terminal will usually freeze. Neither CTRL+C nor
> CTRL+Z will kill the ls process. The gnome-terminal itself is NOT frozen.
> Its window menus are still responsive.
> 

If you reset the terminal via the menu, the terminal will unfreeze (until
the next freeze).

Grab the RPMs from Severn for gnome-terminal and vte.  It will slow down
the terminal I/O and avoid the problem.  I'm not entirely sure whether
this is a fix or just avoiding the problem with more computation (I'm
running on a 300 MHz notebook), but I can now do a "make menuconfig".

	-Paul

