Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWIYJ0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWIYJ0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 05:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWIYJ0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 05:26:03 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:43612 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750784AbWIYJ0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 05:26:00 -0400
Message-ID: <4517A0A2.5020209@tls.msk.ru>
Date: Mon, 25 Sep 2006 13:25:54 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Jeff Garzik <jeff@garzik.org>, Grant Coady <gcoady.lk@gmail.com>,
       Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1 make oldconfig missed SATA
References: <n73eh2d2ido2oimfqn798hp029lshga5qf@4ax.com>            <45171EDA.1040602@garzik.org> <200609250038.k8P0cEX1017825@turing-police.cc.vt.edu>
In-Reply-To: <200609250038.k8P0cEX1017825@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Sun, 24 Sep 2006 20:12:10 EDT, Jeff Garzik said:
>> Grant Coady wrote:
>>> 2.6.18-mm1 make oldconfig didn't pull SATA config from 2.6.18 old screen to
>  
>>> the new libata screen, caught me out -- this may be an issue for 2.6.19 
>>> upgraders that a quick make oldconfig rebuild will fail to boot?
>> The symbols changed.  No facility for upgrading .config symbols... 
>> people who config their own kernels are expected to handle such things...
> 
> I remember getting hit with this several times in the last few -mm's as I
> did bisecting and kept crossing over the patch that did that. Fortunately,
> 'make oldconfig' was nice enough to keep me honest and prompt me for the new
> symbol names.
> 
> What the Kbuild system *could* use is, for the end of 'make oldconfig', a
> report like this for 'y' or 'm' symbols that have evaporated:
> 
> The following enabled symbols found in the .config were not defined in any Kconfig file:
> CONFIG_FROOBY
> CONFIG_DEBUG_FROOBY
> 
> So people aren't totally mystified   Admittedly, I've only gotten bit by
> silently dissapearing symbols 4-5 times since 2.5.55 or so, but the times
> it happened it would have been nice to know....

It already does that, but prints them in the beginning, not after config.
Try make silentoldconfig and see the first screen of warnings when it will
ask the first question.

/mjt
