Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVBUKBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVBUKBf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 05:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVBUKBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 05:01:35 -0500
Received: from eu31-234.clientes.euskaltel.es ([212.55.31.234]:17671 "HELO
	cortafuegos.ziv.es") by vger.kernel.org with SMTP id S261937AbVBUKBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 05:01:33 -0500
Subject: Re: gpio api
From: Asier Llano Palacios <a.llano@usyscom.com>
To: Jamey Hicks <jamey.hicks@hp.com>
In-Reply-To: <4215F1A0.1030805@hp.com>
References: <4215F1A0.1030805@hp.com>
Content-Type: text/plain
Date: Mon, 21 Feb 2005 11:02:24 +0100
Message-Id: <1108980144.15299.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2005 09:57:55.0656 (UTC) FILETIME=[D0C26C80:01C517FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that implementing a GPIO interface is a must-have. And I also
think that your proposal is awesome. I work with GPIOs a lot, and I hate
not doing it in a cross-platform way.

I generally agree with your proposal but I see some missing behaviours.

Configuration that should be done on GPIOs.
- GPIO direction (input/output)
- GPIO modes (standard CMOS / open drain).
- GPIO interruption generation (by level or edge, high, low, raising,
falling)

The GPIOs requesting and numbering should be done by specifying the
chip, the port and the pin. We should be able to manipulate easily a
GPIO from one of 3 I2C chips and another one from our microprocessor.

We should be able to change several pins on the same port simultaneously
(if the driver of the port allows it). Maybe, all the operations should
be done by port (and not by pin), so that we can change several ports
simultaneously. We should be able to register several pins of a port,
and write and read from the port.

I'd like some comments about these features.

-- 
Asier Llano Palacios <a.llano@usyscom.com>

