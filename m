Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbRERU1f>; Fri, 18 May 2001 16:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261549AbRERU1Z>; Fri, 18 May 2001 16:27:25 -0400
Received: from relay03.cablecom.net ([62.2.33.103]:65029 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S261547AbRERU1F>; Fri, 18 May 2001 16:27:05 -0400
Message-ID: <3B058597.A0143D9E@bluewin.ch>
Date: Fri, 18 May 2001 22:27:05 +0200
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Framebuffer drivers and start options
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've used an ATI RageII card with frame buffer driver atyfb compiled
into the kernel and specified 'append = "video=atyfb:800x600@72"' in
lilo.conf. I've just gotten a second computer with a ATI RagePro128 card
(frame buffer driver aty128fb) and compiled both driver as modules. Now
the 'append...' doesn't work any more with any driver. It seems as if
the kernel parameters don't get propagated to the driver modules. Okay I
specified the options for the modules in modules.conf (i.e. options
atyfb 800x600@72) but it didn't help. Both modules use an resolution of
80x30 (characters), regardless what I specify. Afterwards I can switch
the resolution with fbset 800x660-72. When I use modinfo at both drivers
no options where shown. But when I look into the source it seems both
drivers have these options.

Now how can the kernel switch the resolution (append...) if the drivers
doesn't have these options? I's it true that these options won't get
propagated to the drivers if compiled as modules?

How can I figure out which options where allowed? How does/doesn't
modinfo get this information (i.e. matrox frame buffer)?

Is there another solution to get the modularized drivers working besides
compiling into the kernel?

I'm using kernel 2.4.3 with kernel module loader, etc. on i386.

O. Wyss

Please CC, I'm not on the list.
