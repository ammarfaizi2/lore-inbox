Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVAUTjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVAUTjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVAUTjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:39:14 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:54485 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262474AbVAUTi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:38:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mIpf1cj/B9gPozrWdf2bD7tP/VDRK5IGm2bi+0Z8X/gX1xtBu42qhxTn7R1i7oNiQe2o9JI7IwoIKySymSNNF095E8Ahdt3mEbVtwjiq85HG96GExXxNyiWPYA/HLy6ZtIax1aIQ8eYWrx0DKiCiIxilr2sJtvTgwOUBIbDy8TE=
Message-ID: <d120d500050121113867c82596@mail.gmail.com>
Date: Fri, 21 Jan 2005 14:38:56 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Wiktor <victorjan@poczta.onet.pl>
Subject: Re: AT keyboard dead on 2.6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41F15307.4030009@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41F11F79.3070509@poczta.onet.pl>
	 <d120d500050121074831087013@mail.gmail.com>
	 <41F15307.4030009@poczta.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005 20:07:51 +0100, Wiktor <victorjan@poczta.onet.pl> wrote:
> Dmitry Torokhov wrote:
> > Hi,
> >
> > What kernel version are you using? Have you tried 2.6.8.1? - it looks
> > like changes in 2.6.9-rc2-bk3 caused problems on some hardware.
> >
> 
> Hi,
> 
> it looks like 2.6.10 (which I was using) - serio ports are detected ok
> (both on 0x60,0x64, keyboard irq 1, aux irq 12), keyboard also (AT
> Keyboard Translated Set 2 on isa0060/serio) and nothing - while
> detection NumLock (set by BIOS) is turned off and keyboard is dead.
> Maybe someone would be so kind and compare keyboard driver
> hadrware-level parts and (possibly) post patch reversing any changes
> since 2.4?

Ahem, that would be the one wiping out entire input system...

> Any other ideas?

1. Try compiling psmouse as a module and not load it until keyboard
driver (atkbd) is loaded.

2. Try kernel 2.6.8.1 - it looks like changes in 2.6.9-rc2-bk3 are
causing trouble on some systems but I can't figure out the reason.

Also, if you change undef DEBUG to #define DEBUG in
drivers/input/serio/i8042.c, reboot with log_buf_size=131072 and send
me the full dmesg or kernel log I'd appreciate it.

Thanks!

-- 
Dmitry
