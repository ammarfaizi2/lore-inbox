Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTIVGPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 02:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbTIVGPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 02:15:21 -0400
Received: from yonge.cs.toronto.edu ([128.100.1.8]:26623 "HELO
	yonge.cs.toronto.edu") by vger.kernel.org with SMTP id S263011AbTIVGPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 02:15:18 -0400
Date: Mon, 22 Sep 2003 02:15:09 -0400
From: Behdad Esfahbod <behdad@cs.toronto.edu>
X-X-Sender: behdad@qew.cs
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 problems with DHCP and Synaptics (fwd)
Message-ID: <Pine.GSO.4.58.0309220214280.14779@qew.cs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me in replies, if any]

On Tue, 16 Sep 2003, John Weber wrote:
> > 	* I just started using Synaptics patch and Synaptics
> > driver for XFree86.  I have read the synaptics patches carefully
> > and they are not doing anything wrote, so the problem should be
> > in the kernel itself.  The problem is that, when booting up, my
> > Synaptics would be detected if the USB mouse is not plugged!  and
> > would be recognized as a generic PS/2 mouse if the USB mouse is
> > plugged!  I have tried for around 10 times, and this is the exact
> > case.  Any ideas?
>
> I don't use the new driver.  I simply use psmouse_noext=1 on the
> kernel command line (which disables the new driver) to get the old behavior.

I found that since test4 the psmouse_noext=1 is not necessary.
BTW, I fixed my problem by compiling psmouse as a module.
Loading the module with USB mouse connected works, but the code
compiled in the kernel does not.

behdad
