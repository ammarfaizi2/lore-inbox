Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264724AbUDWFv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264724AbUDWFv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 01:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUDWFv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 01:51:26 -0400
Received: from RJ141219067.user.veloxzone.com.br ([200.141.219.67]:22980 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S264724AbUDWFu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 01:50:59 -0400
Date: Fri, 23 Apr 2004 02:50:27 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc2-mm1
Message-ID: <Pine.LNX.4.58.0404230244580.1813@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Several framebuffer driver fixes.  Please test.

Which surely broke my framebuffer, which worked fine with
2.6.6-rc1-mm1.

I have the following in my init script:

if lspci | grep -q 'MGA G400'; then
modprobe matroxfb_base
con2fb /dev/fb0 /dev/tty1
con2fb /dev/fb0 /dev/tty2
fi

And options matroxfb_base vesa=0x117
in /etc/modprobe.conf.

After the above loaded my monitor turned black and the led
started blinking. I just hope such changes can't damage it.

BTW, I'm not sure why, but the con2fb lines only work for the
first tty. I have to manually run "con2fb /dev/fb0 /dev/tty2"
after I boot. Isn't con2fb supposed to do it for any ?

-- 
http://www.pervalidus.net/contact.html
