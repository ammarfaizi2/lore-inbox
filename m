Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWFPLzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWFPLzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWFPLzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:55:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:49872 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750749AbWFPLzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:55:21 -0400
Message-ID: <44929CF5.208@manoweb.com>
Date: Fri, 16 Jun 2006 13:58:45 +0200
From: Alessio Sangalli <alesan@manoweb.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: APM problem after 2.6.13.5
References: <44927F91.6050506@manoweb.com> <84144f020606160305ueae2050lc2d8f47944173971@mail.gmail.com>
In-Reply-To: <84144f020606160305ueae2050lc2d8f47944173971@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:98b9443de46bd48dbf34b16449aa5d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Hi,
> 
> On 6/16/06, Alessio Sangalli <alesan@manoweb.com> wrote:
>> if I enable "APM support" I get a freeze at the very beginning of the
>> boot, without any explicit erro message, just after the PCI stuff. If
>> you need a transcript of the messages at boot, let me know, I will have
>> to write them by hand).
>> 2.6.13.5 is ok. I need APM support to let the "Fn" key and the battery
>> meter work!
> 
> There's a lot of changes between 2.6.13 and 2.6.14.  It would be
> helpful if you could narrow down the exact changeset that broke your


done:

4196c3af25d98204216a5d6c37ad2cb303a1f2bf is first bad commit
diff-tree 4196c3af25d98204216a5d6c37ad2cb303a1f2bf (from
9092b20803e4b3b3a480592794a73030f17370b3)
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Sun Oct 23 16:31:16 2005 -0700

    cardbus: limit IO windows to 256 bytes

    That's what we've always historically done, and bigger windows seem to
    confuse some cardbus bridges. Or something.

    Alan reports that this makes the ThinkPad 600x series work properly
    again: the 4kB IO window for some reason made IDE DMA not work, which
    makes IDE painfully slow even if it works after DMA timeouts.

    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 629d4d303048bffa610017e81e0e744bae08660d
33e154ffe96822d09f37ae2d433de5152216501b M      drivers


let me know any other test I should do to help find a solution to this
problem, thank you!

Alessio Sangalli


