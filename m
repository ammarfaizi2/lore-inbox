Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272838AbRJEU1s>; Fri, 5 Oct 2001 16:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272773AbRJEU1i>; Fri, 5 Oct 2001 16:27:38 -0400
Received: from butterblume.comunit.net ([192.76.134.57]:3589 "EHLO
	butterblume.comunit.net") by vger.kernel.org with ESMTP
	id <S272838AbRJEU11>; Fri, 5 Oct 2001 16:27:27 -0400
Date: Fri, 5 Oct 2001 22:27:55 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: <haegar@space.comunit.de>
To: <thunder7@xs4all.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: can I use an udma-pci card on an alpha?
In-Reply-To: <20011005205909.A6286@middle.of.nowhere>
Message-ID: <Pine.LNX.4.33.0110052215310.38-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001 thunder7@xs4all.nl wrote:

> I had a spare CMD646 udma-card lying around, and put it in my alpha
> (PWS500au). Everything boots fine, but there seems to be no HD
> recognized:

[...]

> Is the bios (which is x86) strictly necessary to set up the drives? I
> tried searching the web for 'udma on alpha' etc. but found nothing.

I am using a Promise 20267 in an DEC Alpha XL 300 with kernel 2.4.10-ac4.

That machine has no bios-support for IDE-Drives, but the kernel (booting
from the ncr scsi-controller) detects my 60gb ibm-disk without problems
and does about 20mb/s.

I've got one real problem:
When I do a "shutdown -r now", the machine is completely dead when loading
the ide-driver after booting up (module).
The only way to get the machine up again is power-cycling.
"shutdown -h now" followed by power-cycle works.

And just now, trying to find out the exact harddisk-model for this mail:
# cat /proc/ide/ide2/hde/identify
-> *boom*, machine dead, network unreachable

Shit - will have to drive to work tomorrow to get my private webserver
back running :(

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

