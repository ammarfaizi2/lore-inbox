Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVA1T73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVA1T73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVA1T40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:56:26 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:42100 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261503AbVA1Tx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:53:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MGhtyzfDKFTycXHp3kcO/lJNplfVO6BhuxziZ2cJlE6bVN18J1FMbAn/BYwMCMjOxWDCBEDCoy1Q/AXKEIWCmJh6o5hfQ2dB8JtFHTJZrjPI0X0g5A5DClzN3iN2C0NyMnFLRiOznjQJT15tYBYRuHcmrqLl9yMEDaGWOnRcQkw=
Message-ID: <d120d50005012811534eb1ed70@mail.gmail.com>
Date: Fri, 28 Jan 2005 14:53:57 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Wiktor <victorjan@poczta.onet.pl>
Subject: Re: AT keyboard dead on 2.6
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <41FA972F.2000604@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41F11F79.3070509@poczta.onet.pl>
	 <d120d500050121074831087013@mail.gmail.com>
	 <41F15307.4030009@poczta.onet.pl>
	 <d120d500050121113867c82596@mail.gmail.com>
	 <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz>
	 <d120d50005012806467cc5ee03@mail.gmail.com>
	 <41FA90F8.6060302@poczta.onet.pl>
	 <d120d5000501281127752561a3@mail.gmail.com>
	 <41FA972F.2000604@poczta.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 20:49:03 +0100, Wiktor <victorjan@poczta.onet.pl> wrote:
> Hi,
> 
> > Could you please try editing drivers/input/serio/i8042.c and add
> > udelay(20) before and after calls to i8042_write_data() in
> > i8042_kbd_write() and i8042_command().
> 
> of course i could, will it make kernel not detect smoked AUX port?
> (problem is solved by i8042.noaux=1 cause my hardware has smoked PS/2
> port) i would rather think about testing devices before assuming thet
> work and trying to use them (maybe not as standard kernel feature, but
> it would be nice stuff for people with self-built machines where not
> everything works).

We do test AUX port and your port appears to be perfectly functional
from the kernel point of view - it porperly responds to AUX_LOOP
commands, does not claim to support MUX mode and KBC properly sets
status register when asked to disable interface...

-- 
Dmitry
