Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTL2Da3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 22:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbTL2Da3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 22:30:29 -0500
Received: from smtp2.att.ne.jp ([165.76.15.138]:1254 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S262569AbTL2DaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 22:30:24 -0500
Message-ID: <007101c3cdbc$046a58d0$2fee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <dan@eglifamily.dnsalias.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Blank Screen in 2.6.0
Date: Mon, 29 Dec 2003 12:28:41 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan wrote:

> Upgraded to the lastest module-init-tools, and disabled the
> frame buffer support in the kernel. So the only graphic option enabled is
> text mode selection. But when I boot I still get a blank screen!
> My lilo.conf contains a line: vga=773, which works beautifully under
> RedHat's stock 2.4.20-8.

In my experience the vga= option worked with every 2.4 kernel in every
distro that I had used, continued working with 2.6 test* and 0 in Red Hat
7.3, but blanked the screen with 2.6 test* and 0 in SuSE 8.1 and SuSE 8.2.
Haven't tried other configurations with 2.6.

But now you're getting the same with a Red Hat distro, so it's looking
pretty random.

The decision to release 2.6.0 with the same broken vga= option that was
reported many times in 2.6.0-test* makes me think that vga= is not intended
to work.

By the way, on one machine I experimented with putting the framebuffer
driver back into the kernel after deleting the vga= option, and it
automatically expanded to all of the screen and it worked.  I don't know if
this is random behavior either, for example it probably doesn't work on the
machines of people who told you to disable your framebuffer and it probably
doesn't work on the machines of people who didn't check whether you obeyed
the Post Hallowe'en doc.  But if you're brave you might try it.

