Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbUKHRGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUKHRGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbUKHRFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:05:43 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:28384 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261929AbUKHQUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:20:10 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 17:11:13 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: cursor bug
Message-ID: <20041108161113.GA23504@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

There is annonying cursor bug in recent kernels (started in 2.6.10-rc1
IIRC).  There kernel seems not to keep track of the cursor state
correctly when switching virtual terminals.  Here is how to reproduce
it:

  (1) boot with vesafb (thats what I'm using, maybe it shows on other
      framebuffers and/or vgacon as well).
  (2) login into one terminal, then type "echo -ne '\033[?17;15;239c'".
      You should have a nice, yellow and *not* blinking cursor block.
      That is what I have in my .profile because I can't stand the
      blinking cursors.
  (3) Switch to another terminal.  The cursor goes into blinking
      underscore mode now (i.e. the default cursor).
  (4) Switch back to the first terminal.  Now you have a yellow block
      with the last two pixel lines (i.e. the underscore) blinking.

Oh no.  Please fix that.  Thank you.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
