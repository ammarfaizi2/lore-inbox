Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTL3AhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 19:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTL3AhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 19:37:23 -0500
Received: from smtp1.fre.skanova.net ([195.67.227.94]:14067 "EHLO
	smtp1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261753AbTL3AhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 19:37:22 -0500
To: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI problems (was: Re: Synaptics PS/2 driver and 2.6.0-test11)
References: <20031229215913.GH916@mail.muni.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Dec 2003 01:37:11 +0100
In-Reply-To: <20031229215913.GH916@mail.muni.cz>
Message-ID: <m21xqngmyw.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz> writes:

> Hello,
> 
> I've found that problem with synaptics is really related to some ACPI troubles.
> I've suspected synaptics touchpad to do some interrupt bursts and it does.
> Just single button press and relelase generates about 500 interrupts!!! I wonder
> if it is driver related or really hardware related...

That's normal. The hardware generates 80 packets/second and it keeps
generating packets 1 second after you stop using the touchpad. Each
packet is 6 bytes and the i8042 controller generates one
interrupt/byte.

500 interrupts/s shouldn't be any problem to handle though.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
