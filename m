Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130521AbRCLRlf>; Mon, 12 Mar 2001 12:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbRCLRl0>; Mon, 12 Mar 2001 12:41:26 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22547 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130521AbRCLRlL>; Mon, 12 Mar 2001 12:41:11 -0500
Subject: Re: Linux 2.4.2ac18
To: h.lubitz@internet-factory.de (Holger Lubitz)
Date: Mon, 12 Mar 2001 17:43:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AAD065E.FC34E8F3@internet-factory.de> from "Holger Lubitz" at Mar 12, 2001 06:24:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14cWM3-0002Hk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But this won't catch FSB overclocking at all (which nowadays seems the
> most common way of oc-ing, since it does not involve any modifications
> to the CPU other than maybe a better cooler). Or am I missing something?

The overclocking experiment was a side line

> And what exactly does the multiplier reading alone buy us? (No offense
> meant - I am just curious because I really liked the feature, did not
> even know that it was possible, and am a bit sad to see it go again)

We need to detect configurations where the bus speed is the same for all cpus
and the multiplier is not. These are legal MP configurations. In these cases
we need to (but currently dont) disable the TSC usage for anything but
delay timing as the TSC isnt lock-step

