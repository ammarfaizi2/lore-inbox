Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129445AbRBRTeR>; Sun, 18 Feb 2001 14:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129940AbRBRTeI>; Sun, 18 Feb 2001 14:34:08 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:31239 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129445AbRBRTdz>;
	Sun, 18 Feb 2001 14:33:55 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102181933.WAA27194@ms2.inr.ac.ru>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
To: chris@scary.beasts.org (Chris Evans)
Date: Sun, 18 Feb 2001 22:33:44 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <Pine.LNX.4.30.0102181843200.21465-100000@ferret.lmh.ox.ac.uk> from "Chris Evans" at Feb 18, 1 07:25:53 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So the actual timeout would be 2 * SO_SNDTIMEO.

It will timeout if write of some page blocks for SO_SNDTIMEO.
If transmission of any page never takes more than SO_SNDTIMEO it never
times out.

You can think about sendfile() as subroutine doing:

	for (;;) {
		read(4K from fdin);
		write(4K to fdout);
	}

All the options apply to each read()/write() separetely, so that... alas.

Alexey
