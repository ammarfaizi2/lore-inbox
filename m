Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbTF2BSL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 21:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbTF2BSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 21:18:11 -0400
Received: from smtp1.fre.skanova.net ([195.67.227.94]:11249 "EHLO
	smtp1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265504AbTF2BSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 21:18:09 -0400
Date: Sun, 29 Jun 2003 03:32:20 +0200 (CEST)
From: Johan Braennlund <spahmtrahp@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: neilb@cse.unsw.edu.au
Subject: Re: PATCH - ALPS glidepoint/dualpoint driver for 2.5.7x
Message-ID: <Pine.LNX.4.53.0306290122250.25086@h192n1fls22o1048.telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At first I tried posting this to linux.kernel, since I thought that was a
bidirectional gateway, but the post hasn't showed up. Apologies if you see
this twice.

Neil Brown <neilb@cse.unsw.edu.au> wrote:

> Hi,
>  The following adds support for the ALPS glidepoint/dualpoint pointing
>  devices to the mouse driver in 2.5.7x

>  It "works-for-me" but there are issues that probably need to be
>  addressed.

Hi! Thank you for the patch. It looks interesting, but unfortunately it
doesn't work very well for me. I have an Acer Aspire laptop with a
four-button Alps touchpad (left,right and two up/down scroll buttons). The
"down" button functions as the middle mouse button, but I've never been
able to get the "up" button properly recognized under linux.

If I apply your patch to 2.5.73, none of the buttons work (except for
tapping for left-click), neither in X nor with gpm, but touchpad movement
works fine, with increased sensitivity compared to the standard driver.
Unpatched 2.5.73 works as expected.

gpm commandline: gpm -t ps/2 -m /dev/psaux

XF86Config:

Section "InputDevice"
        Identifier      "Configured Mouse"
        Driver          "mouse"
        Option          "CorePointer"
        Option          "Device"                "/dev/psaux"
        Option          "Protocol"              "GlidePointPS/2"
        Option          "Buttons"               "4"
EndSection

My C skills are pretty meager but if there's anything I can do in the way
of debugging, I'd be happy to.

Johan

