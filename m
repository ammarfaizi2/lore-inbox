Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVLTUDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVLTUDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVLTUDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:03:36 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:53714 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932072AbVLTUDf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:03:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YtpBIVEk6Z5j1KAtPjL+zVI1EfPCWS+pVY/0yc7MhUDob+db6LTdEMjYuZF+8rMX2AfT1cqAlwThabZI98ZA/v0om1O8o+HUv5tTfcFBCfwuBz5M3F1UAwmmOPhMbl2jXzI/ZtrIi+84/7JK1ozzf/4jZEQBqpVDUZTd6Wp+PdA=
Message-ID: <9a8748490512201203s7fce043byfce95b11307008d5@mail.gmail.com>
Date: Tue, 20 Dec 2005 21:03:33 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: vgacon regression
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antonino,

[starting a new thread and adding Linus to CC since this problem is
now also in his tree as well as Andrews]

The problem I observed in 2.6.15-rc5-mm2 with the (vgacon) console
getting corrupted after starting X is still present in 2.6.15-rc5-mm3
and is now also present in mainline (2.6.15-rc6-git1).

Latest kernel that I know of that is problem free is 2.6.15-rc5-git4.


The problem in a nutshell:

  If I boot with vga=791 everything is fine with both mainline kernels
and -mm and
  I don't see any of the problems noted below.

  If I boot with vga=normal then I see these two problems :

    1) Just after starts and switches resolution but before the login
manager is
        displayed I briefly see a corrupted graphical image that is
sometimes what
        looks like a garbled snapshot of the text-mode console and sometimes a
        garbled version of the X login screen or a previous KDE desktop session.

    2) If I switch back to a text mode console with ctrl+alt+f6 from
within X (or
        even shut down X), then the text console is completely
garbled. It still has
        the resolution it had at boot but it's displaying lots of
coloured (some of
        them blinking) boxes and random characters all over, including
some bits
        that look like partial boot-up messages (half a word here, two
words there,
        with random bits inserted, etc) - in short, it's completely messed up.
        The console stil remains functional in the sense that you can
log in blind and
        run commands just fine, but no amount of "reset" or "clear"
will fix the
        breakage.


Any advice as to what patches I can try to revert?

While I wait for a reply I'll test the mainline kernels between
2.6.15-rc5-git4 and 2.6.15-rc6-git1 to try and determine the first one
that breaks.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
