Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275767AbRJNQge>; Sun, 14 Oct 2001 12:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275778AbRJNQgY>; Sun, 14 Oct 2001 12:36:24 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:11783 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S275767AbRJNQgI>;
	Sun, 14 Oct 2001 12:36:08 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110141636.UAA05762@ms2.inr.ac.ru>
Subject: Re: TCP acking too fast
To: ak@muc.de (Andi Kleen)
Date: Sun, 14 Oct 2001 20:36:15 +0400 (MSK DST)
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org
In-Reply-To: <20011014133004.34133@colin.muc.de> from "Andi Kleen" at Oct 14, 1 01:30:04 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I just checked and the 2.4 kernel doesn't have the PSH quickack check
> anymore,

Right, it is removed because all the PSHed packets are acked as soon
as rcvbuf is completely drained and window is full open.

See? It is the reason of "too frequent" ACKs and I daresay they
are not too frequent and it is impossible to do something with this.
These ACKs are an _absolute_ demand and delay by some small time
helps nothing destroying performance instead.

Well, it is the place, commented with "Dubious? ... final cut."
It is enough to delete it to avoid "too frequent" ACKs and to return
to too rare ACKs instead.

Alexey
