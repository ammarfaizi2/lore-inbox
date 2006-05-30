Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWE3Mb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWE3Mb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWE3Mb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:31:59 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:19717 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751476AbWE3Mb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:31:58 -0400
Message-ID: <447C3B3D.10705@superbug.co.uk>
Date: Tue, 30 May 2006 13:31:57 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Keith Chew <keith.chew@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IO APIC IRQ assignment
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
In-Reply-To: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Chew wrote:
>
> We asked the manufacturers if they can do a physical modication for
> us, but unfortunately this is not possible. The engineer did mention
> that under Windows XP in "IO APIC" mode, it is possible to assign
> different IRQs to the USB and BTTV.
>
> Is this possible in Linux? We have tried enabling IO APIC in the
> kernel, but the IRQs are still shared.
>
> Please advise if it is even possible in Linux to achieve what we want.
>

You could try enabling "Bus Options" ->
[*]   Message Signaled Interrupts (MSI and MSI-X)

or in .config
CONFIG_PCI_MSI=y

It only works for PCI devices.

