Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129353AbQKCAAw>; Thu, 2 Nov 2000 19:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbQKCAAm>; Thu, 2 Nov 2000 19:00:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28757 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129353AbQKCAA3>; Thu, 2 Nov 2000 19:00:29 -0500
Subject: Re: select() bug
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 3 Nov 2000 00:01:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8tsupp$gh8$1@cesium.transmeta.com> from "H. Peter Anvin" at Nov 02, 2000 03:53:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rUI9-00027M-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has anyone considered the possibility of expanding the buffer of
> high-traffic pipes?

Do that too much and the data falls out of L1 cache before we context switch. 
Its a rather complex juggling game. DaveM's kiovec pipe patches avoid some of
this by cheating and going user->user

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
