Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTLJRIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTLJRIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:08:15 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:42251 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S262608AbTLJRIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:08:14 -0500
Date: Wed, 10 Dec 2003 18:08:09 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.23: pc_keyb.c] request_irq() without free_irq().
In-Reply-To: <20031210085255.53747fde.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.33.0312101805550.1130-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, Randy.Dunlap wrote:

> On Wed, 10 Dec 2003 15:32:22 +0100 (CET) Guennadi Liakhovetski <gl@dsa-ac.de> wrote:
>
> | Hello
> |
> | Looks like the the counterpart for kbd_request_irq() is missing. Am I
> | right?
>
> Did you find the counterpart for kbd_request_region()?
>
> In 2.4.x, the pc keyboard driver option is Y/N.  It can't be a module.
> If it's built into the kernel, it just hangs around until reboot.
> It doesn't need to release resources when the kernel is shutting down.

Yep, I noticed already, that there's no release method at all:-)) I'm just
adapting the code to an ARM platform (actually, the patch already exists
and already works), and, no, we don't really need to unload it, but, just
thought, wasn't quite clean... But, well, it's probably not going to
change in 2.4. Not that it was very needed:-)

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

