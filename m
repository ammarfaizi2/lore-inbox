Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUFGOe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUFGOe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUFGOe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:34:28 -0400
Received: from loki.snap.net.nz ([202.37.101.41]:48140 "EHLO loki.snap.net.nz")
	by vger.kernel.org with ESMTP id S264693AbUFGOe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:34:27 -0400
Date: Tue, 8 Jun 2004 02:42:47 +1200 (NZST)
From: Keith Duthie <psycho@albatross.co.nz>
To: Sebastian Kloska <kloska@scienion.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
In-Reply-To: <40C46F7F.7060703@scienion.de>
Message-ID: <Pine.LNX.4.53.0406080228110.27816@loki.albatross.co.nz>
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz>
 <40C46F7F.7060703@scienion.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004, Sebastian Kloska wrote:

>   So if anybody out there could give me guidance on how the apm code
>   might interact with the ALSA sound system it would be highly
>   appreciated....

In a word, badly. For at least one chipset, suspending while outputting
to the pcm device causes the program outputting to the pcm device to enter
the uninterruptible sleep state. A reboot is then required for the pcm
device to be usable again...

(I attempted to report this back in February, but my bug report and
workaround patch apparently didn't get through the alsa-devel spam
filters.)
-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
