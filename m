Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVEVOnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVEVOnw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 10:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVEVOnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 10:43:52 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:30540 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261813AbVEVOnu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 10:43:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZwIHMmXC38xUNGDgmoWgz8wuhyPKK0FpfLYGJ0x3hRdpkiHQlSSY/0/g6X9Z1EQQxbqr+ckHSueHhxNp2pSWwW8UMxnImIsHsF6C1Dk25+AVjl73O54LY463YA//uPPHJFPNAdGhClbxyFpXpxzTnGyInMcR3ba00VbwZSyym+4=
Message-ID: <9e47339105052207431634c341@mail.gmail.com>
Date: Sun, 22 May 2005 10:43:50 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: keymaps, event interface and multiple keyboards
Cc: vojtech@suse.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on keyboard support for Xgl (the OpenGL based accelerated
Xserver). X implements it's own keymaps but since this is all new code
I can look at using the kernel ones.  I haven't been a fan of having
two separate systems. Since I have little experience with keyboard
support I could use some help in getting the code right.

One goal of XGL is to allow multiuser. It does this by using
independent framebuffers and the event interface for keyboard/mouse.
This all works but it ignores the VT system.

Now I'm starting to look at the kernel keymap support. Kernel keymaps
are tied to the VT system. There is only one VT system and it is not
multiuser. So how do I get support for multiple users (maybe with
different keyboards) using kernel keymap? Should keymap support be
broken out of the VT code and moved to input?

-- 
Jon Smirl
jonsmirl@gmail.com
