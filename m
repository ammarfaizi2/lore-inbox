Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbQKNTDG>; Tue, 14 Nov 2000 14:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130548AbQKNTCz>; Tue, 14 Nov 2000 14:02:55 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:516 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S130471AbQKNTCr>;
	Tue, 14 Nov 2000 14:02:47 -0500
Date: Tue, 14 Nov 2000 12:32:43 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: linux-kernel@vger.kernel.org
Subject: opl3.o initialization problems in 2.4
Message-ID: <Pine.LNX.4.21.0011140825020.1788-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I continue to see apparent interaction problems between sb.o and opl3.o
during system initialization.  Several people have reported problems
with the opl3.o module not loading or not working properly.  A
workaround was developed which results in a functional system; if sb.o
is compiled as built-in and opl3.o is compiled modular things work.  

My working theory is that the soundcard must be initialized and the
driver functioning before the opl3 module can initialize its function on
the card.  Currently, the opl3 code is executed before the soundcard
code and is unable to initialize the fm synthesizer.  

I hate to reignite the link order war, but I would appreciate a
clarification of the situation.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
