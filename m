Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312871AbSC0Agx>; Tue, 26 Mar 2002 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312872AbSC0Agn>; Tue, 26 Mar 2002 19:36:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62475 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312871AbSC0Agi>; Tue, 26 Mar 2002 19:36:38 -0500
Subject: Re: signal_pending() and schedule()
To: melkorainur@yahoo.com (Melkor Ainur)
Date: Wed, 27 Mar 2002 00:53:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020327001955.99099.qmail@web21203.mail.yahoo.com> from "Melkor Ainur" at Mar 26, 2002 04:19:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16q1gi-0004OW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but fails for netscape. In debugging this, I observe
> that after calling schedule_timeout(), the sigpending
> bit appears to be set immediately and thus 

It means a signal was delivered

> schedule() doesn't actually put the process to sleep.

Because the signal is pending. The kernel is expecting to return or take
some action and return to user space if its an interrutible sleep
