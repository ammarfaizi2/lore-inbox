Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130510AbRBVKL4>; Thu, 22 Feb 2001 05:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRBVKLq>; Thu, 22 Feb 2001 05:11:46 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130510AbRBVKLh>; Thu, 22 Feb 2001 05:11:37 -0500
Subject: Re: Very high bandwith packet based interface and performance problems
To: nyet@curtis.curtisfong.org (Nye Liu)
Date: Thu, 22 Feb 2001 10:14:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010221172431.A10657@curtis.curtisfong.org> from "Nye Liu" at Feb 21, 2001 05:24:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VslR-0003ow-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and the transmitter is unrestricted, what happens?
> Does it have to do with TCP_FORMAL_WINDOW (eg. automatically reduce window
> size to zero when queue backs up?)

Read RFC1122. Basically your guess is right. The sender sends data, and gets
back acks saying 'window 0'. It will then do exponential backoffs while
polling the 0 window as it backs off (ack being unreliable)


