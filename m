Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUI0KcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUI0KcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 06:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUI0KcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 06:32:03 -0400
Received: from cantor.suse.de ([195.135.220.2]:52132 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266615AbUI0KcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 06:32:00 -0400
Message-ID: <4157B04B.2000306@suse.de>
Date: Mon, 27 Sep 2004 08:16:43 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: mlock(1)
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams> <20040925011800.GB3309@dualathlon.random>
In-Reply-To: <20040925011800.GB3309@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> random keys are exactly fine, but only for the swap usage on a desktop
> machine (the one I mentioned above, where the user will not be asked for
> a password), but it's not ok for suspend/resume, suspend/resume needs
> a regular password asked to the user both at suspend time and at resume
> time.

Why not ask on every boot? (and yes, the passphrase could be stored on a
fixed disk location - hashed with a function of sufficient complexity
and number of bits, just to warn the user if he does a typo, couldn't
it?). If suspend is working, you basically never reboot. So why ask on
suspend _and_ resume? This also solves the "suspend on lid close" issue.

And a resume is - in the beginning - a boot, so just ask early enough
(maybe the bootloader could do this?)

I'm not a crypto expert at all, just thinking loud...

    Stefan

