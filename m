Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272202AbRH3NIF>; Thu, 30 Aug 2001 09:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272204AbRH3NHz>; Thu, 30 Aug 2001 09:07:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39183 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272202AbRH3NHl>; Thu, 30 Aug 2001 09:07:41 -0400
Subject: Re: smp freeze on 2.4.9
To: philippe.amelant@free.fr (Philippe Amelant)
Date: Thu, 30 Aug 2001 14:06:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <999174855.2667.4.camel@avior> from "Philippe Amelant" at Aug 30, 2001 02:34:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cRWe-00013T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> interresting, i notice that i have some error apic in kernel message
> with 2.4.3
> i will search that on lkml archive

Lots of apic errors imply problems on the link between the processors and
io controller. A few is basically ok (there is a checksum) but a huge number
and one day it'll checksum a bad frame ok and you are history

There is also a problem with Linus tree where apic errors causing event
replays where the erroring component was not the CPUs can cause crashes.
That is fixed in -ac.

Alan
