Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUGEJ4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUGEJ4q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 05:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUGEJ4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 05:56:46 -0400
Received: from aun.it.uu.se ([130.238.12.36]:61840 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265974AbUGEJ4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 05:56:44 -0400
Date: Mon, 5 Jul 2004 11:56:35 +0200 (MEST)
Message-Id: <200407050956.i659uZvo003145@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: azarah@nosferatu.za.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4] lockup on boot with 2.4.26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jul 2004 00:15:52 +0200, Martin Schlemmer wrote:
>I have tried to update my gateway's kernel to 2.4.26 (Been running
>happily on 2.4.17, but a bit _old_, so finally decided this weekend
>to try and update it).   At boot though it only gets to:
>
>--
>Uncompressing kernel... booting linux...
>--
>
>and then locks hard (the capslock and scroll lock leds lids)
>
>Its an old P3 450 on an Asus P2B (BX440 chipset).  .config is pretty
>much the same as for the 2.4.17 kernel.

There's no inherent reason your P2B shouldn't boot. I know for
a fact that its successor, the P3B-F, boots just fine.

Your .config contains a lot of stuff not needed for booting,
you should eliminate it and try a minimal .config. In your
case, I'd definitely remove

CONFIG_EDD=y
CONFIG_ACPI=y
CONFIG_FB=y

and possibly also

CONFIG_ISAPNP=y
CONFIG_SENSORS=y

You can always add them back once you've identified the breakage.
