Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271792AbRHUShV>; Tue, 21 Aug 2001 14:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271807AbRHUShH>; Tue, 21 Aug 2001 14:37:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15877 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271790AbRHUSfw>; Tue, 21 Aug 2001 14:35:52 -0400
Subject: Re: PROBLEM: select() says closed socket readable
To: davids@webmaster.com (David Schwartz)
Date: Tue, 21 Aug 2001 19:38:51 +0100 (BST)
Cc: jaggy@purplet.demon.co.uk (Mike Jagdis), linux-kernel@vger.kernel.org
In-Reply-To: <NOEJJDACGOHCKNCOGFOMIEKBDFAA.davids@webmaster.com> from "David Schwartz" at Aug 21, 2001 10:35:10 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZGQN-0008QO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	No, because 'select' is defined to work the same on both blocking and
> non-blocking sockets. Roughly, select should hit on read if a non-blocking
> read wouldn't return 'would block'.

Select is not reliable for a blocking socket in all cases. There is always 
a risk select may return "data to read" and the read will find there is now
none. It isnt going to bite anyone on Linux with our current protocols but
it may bite portable code
