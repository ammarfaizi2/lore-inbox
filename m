Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTKCAqP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 19:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTKCAqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 19:46:15 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:16326 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261875AbTKCAqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 19:46:13 -0500
Subject: Re:No backlight control on PowerBook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dustin Lang <dalang@cs.ubc.ca>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
Content-Type: text/plain
Message-Id: <1067820334.692.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 03 Nov 2003 11:45:34 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
X-Bad-Reply: References but no Re:
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-03 at 06:23, Dustin Lang wrote:
> Hi,
> 
> I just bought a new PowerBook G4 and installed Linux on it.  Now the
> tweaking begins!  One of the first orders of business is getting power
> management working, and I'm a bit stuck.

You can't expect a machine just released a couple of weeks ago by
Apple to be fully supported by linux, do you ? :)

> I'm running kernel version 2.4.22 with Ben Herrenschmidt's 2.4.23-pre5
> patches.
> 
> On startup, arch/ppc/platform/pmac_backlight.c doesn't recognize the
> backlight controller.  It checks compatibility with a couple of specific
> machines, and then checks compatibility with the backlight controller.
> This appears to be the same check that is performed in the Darwin/xnu
> kernel (at least the version that I found...).

If it's a new Mobility 9600 machine, then I expect my 2.6 tree
(bk://ppc.bkbits.net/linuxppc-2.5-benh or rsync from source.mvista.com)
to work, though the actual backlight "scale" may not be fully correct
yet.

> Any (non-null) pointers would be appreciated!

Unfortunately, there's isn't much HW documentation available for these
babies, other than reading Apple darwin source, Open Firmware forth
code, etc...

Regarding overall power management (that is machine sleep), it is not
supported on these machines yet. The blocking factor is the new ATI chip,
which need to be rebooted from scratch. ATI told me they might be able to
send me tables to do that though, so there is hope.

Ben.

