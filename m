Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264908AbTFQPGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 11:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTFQPGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 11:06:33 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:35047 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264891AbTFQPGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 11:06:32 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Herbert Schmid <sairia@phaidon.philo.at>
Date: Tue, 17 Jun 2003 17:19:55 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PROBLEM: matroxfb broken with G450 in 2.4.21 (and 2.4.2
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
X-mailer: Pegasus Mail v3.50
Message-ID: <4AE620E3921@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jun 03 at 15:45, Herbert Schmid wrote:
> [1.] Matroxfb doesn't init a Matrox G450 DH correctly.
> 
> [2.] The console stays in VGA-Mode. If the VGA-console is not compiled
> in, the screen is not updated after the "Ok, booting the kernel."
> message. You won't see neither the kernel bootstraping nor any console
> login, but working blind is possible. X11 works fine.

> CONFIG_FB_MATROX=y
> # CONFIG_FB_MATROX_MILLENIUM is not set
> # CONFIG_FB_MATROX_MYSTIQUE is not set
> CONFIG_FB_MATROX_G450=m
> CONFIG_FB_MATROX_I2C=y
> CONFIG_FB_MATROX_PROC=y
> # CONFIG_FB_MATROX_MULTIHEAD is not set

Did you run 'make oldconfig' on the old configuration? I see
"bool '   G100/G200/G400/G450/G550 support' CONFIG_FB_MATROX_G450"
in drivers/video/Config.in, so 'm' is illegal value for this choice, 
and anything can happen, including explosion of your computer, or 
creating driver which supports no hardware...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

