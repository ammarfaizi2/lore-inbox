Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTE1EZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 00:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTE1EZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 00:25:13 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:27586 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264496AbTE1EZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 00:25:12 -0400
Date: Wed, 28 May 2003 14:38:23 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: pcmcia oops (a real one! honest!)
Message-ID: <20030528043823.GA485@zip.com.au>
References: <20030528042610.GD6501@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528042610.GD6501@zip.com.au>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 02:26:10PM +1000, CaT wrote:
> removed my xircom pcmcia realport card and put in another. End result was
> total loss of ps2 keyboard functionality (everything else, inc the ps2 mouse
> still works). I then removed the xircom card. The following was in dmesg:

A bit more info:

lspci segfaults
cat /proc/pci segfaults
cat /proc/bus/pci/devices segfaults
cat /proc/bus/pci/02/00.* segfaults BUT that is only because it is 00.0
that is causing it. This represents the ethernet side of the card and 00.1
is fine.

also, processes hung on me. bash hung on exit and took screen with it. mutt
hung on exit also and took screen with it aswell.

on reboot init reported some hung processes and all up it all went
spaz on me with two of my partitions not being able to be unmounted
(prolly cos of the hung processes) and the e100 driver dieing in
e100_notify_reboot (or somesuch name). the laptop refused to reboot and
I had to powercycle.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
