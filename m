Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVBUXr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVBUXr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 18:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVBUXr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 18:47:29 -0500
Received: from one.firstfloor.org ([213.235.205.2]:53906 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262130AbVBUXr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 18:47:26 -0500
To: =?iso-8859-1?q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: memory management weirdness
References: <4219E62D.7000009@ribosome.natur.cuni.cz>
From: Andi Kleen <ak@muc.de>
Date: Tue, 22 Feb 2005 00:47:24 +0100
In-Reply-To: <4219E62D.7000009@ribosome.natur.cuni.cz> (Martin
 =?iso-8859-1?q?MOKREJ=A9's?= message of "Mon, 21 Feb 2005 14:46:21 +0100")
Message-ID: <m14qg5mq5v.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ© <mmokrejs@ribosome.natur.cuni.cz> writes:

> Hi,
>   I have received no answer to my former question
> (see http://marc.theaimsgroup.com/?l=linux-kernel&m=110827143716215&w=2).

That's because it's a BIOS problem.

There are limits on how much Linux can work around BIOS breakage.


>   Although I've not re-tested this today again, it used to help a bit to specify
> mem=3548M to decrease memory used by linux (tested with AGP card plugged in, when
> bios reported 3556MB RAM only).
>
>   I found that removing the AGP based videoc card and using an old PCI based
> video card results in bios detecting 4072MB of RAM. But still, the machine was
> slow. I've tried to "cat >| /proc/mtrr" to alter the memory settings, but the
> result was only a partial speedup.
>
>   I'm not sure how to convince linux kernel to run fast again.

It's most likely a MTRR problem. Play more with them.


>   Finally, I put back two 512MB memory modules to have only 3GB RAM physically,
> and the result is at http://www.natur.cuni.cz/~mmokrejs/tmp/128MB/only_phys_3GB/.


The cheaper Intel chipsets don't support >4GB at all, and you always
need some space below 4GB for PCI memory mappings/AGP aperture etc.


>   About a week ago I tried to contact ASUS, but no answer so far from their
> techinical support through some web robot.
> http://vip.asus.com/eservice/techmailstatus.aspx?ID=WTM200502111723398547
> I do not recommend their "greatest" and real "flag-ship" P4C800-E-Deluxe
> motherboard for use with memory sizes above 3GB (although they claim 4GB
> is possible). BIOS is the latest release 1.19, although 1.20.001 was tested
> as well.

In general non server boards tend to be not very well or not at all
tested with a lot of memory ("a lot" is defined as >2GB for higher end
desktop boards, or >1GB on very cheap desktop boards). That is a
common problem on other motherboards too; Asus is not alone with this.

-Andi
