Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288731AbSBRWaS>; Mon, 18 Feb 2002 17:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288685AbSBRWaI>; Mon, 18 Feb 2002 17:30:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15625 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288731AbSBRW3s>; Mon, 18 Feb 2002 17:29:48 -0500
Subject: Re: jiffies rollover, uptime etc.
To: greearb@candelatech.com (Ben Greear)
Date: Mon, 18 Feb 2002 22:43:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), oh@novaville.de (Oliver Hillmann),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C717DEA.7090309@candelatech.com> from "Ben Greear" at Feb 18, 2002 03:19:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16cwUx-00073d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder, is it more expensive to write all drivers to handle the
> wraps than to take the long long increment hit?  The increment is

Total cost of handling it right - 0 clocks. Its simply about maths order
and sign 

> Maybe the non-atomicity of the long long increment is the problem?

A big one yes.

> Does this problem still exist on 64-bit machines?

Not in the same way - you'll need a lot of years before you worry about it.
