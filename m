Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136494AbRD3RBM>; Mon, 30 Apr 2001 13:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136492AbRD3RBC>; Mon, 30 Apr 2001 13:01:02 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:56069 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S136494AbRD3RA5>;
	Mon, 30 Apr 2001 13:00:57 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104301700.VAA18188@ms2.inr.ac.ru>
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
To: davem@redhat.com (David S. Miller)
Date: Mon, 30 Apr 2001 21:00:09 +0400 (MSK DST)
Cc: ralf@nyren.net, linux-kernel@vger.kernel.org
In-Reply-To: <15084.62398.56283.772414@pizda.ninka.net> from "David S. Miller" at Apr 29, 1 10:10:22 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> My current theory is that tcpblast does something erratic when the
> error occurs.

It has buffer size of 32K, so that it faults at enough large chunk sizes.

Erratic errno is because this applet prints errno on partial write.

Oops is apparently because I did something wrong in do_fault yet.
Seems, you were right telling that this place looks dubious. 8)

Alexey
