Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262447AbTCIJSi>; Sun, 9 Mar 2003 04:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbTCIJSi>; Sun, 9 Mar 2003 04:18:38 -0500
Received: from wall.ttu.ee ([193.40.254.238]:8211 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id <S262447AbTCIJSh>;
	Sun, 9 Mar 2003 04:18:37 -0500
Date: Sun, 9 Mar 2003 11:29:05 +0200 (EET)
From: Siim Vahtre <siim@pld.ttu.ee>
To: <linux-kernel@vger.kernel.org>
cc: <jsimmons@infradead.org>
Subject: Re: Console weirdness
In-Reply-To: <3E6AF463.4020706@portrix.net>
Message-ID: <Pine.SOL.4.31.0303091125560.28624-100000@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003, Jan Dittmer wrote:

> But still, switching back from X to console corrupts the display.
> Switching back is fine though using the fbdev.diff patch. Without
> switching back and force works fine, except that the last line isn't
> properly redrawn (rivafb).

I am using rivafb with 2.5.64-bk2 kernel and with latest fbdev patches
and have following (minor) problems:

* switching to X and back ruins the colours totally. Soulution is to
fbset back to default mode. (I've even made hotkey for that ;-) )

* changing modes(to other than 640x480) will change the resolution but
not the 'console window' itself. That is - I have 640x480 window on the
corner for text console but actually 800x600 resolution. (Maybe it is a
feature? How to get it full-screened, anyway?)

* changing modes on one tty (even though -a was specified with fbset)
will not change modes on other ttys. When switching ttys with different
resolution, the screen blanks and I again have to use my hotkey to fbset
back to default resolution.

* using cat /dev/fb1 will produce kernel NULL pointer :-)

Oh.. and one quick question.. docs are talking about 'nice large console
without using tiny, unreadable fonts'. How to archieve that?

