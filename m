Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288878AbSAFOhX>; Sun, 6 Jan 2002 09:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288960AbSAFOhN>; Sun, 6 Jan 2002 09:37:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4883 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288878AbSAFOhJ>; Sun, 6 Jan 2002 09:37:09 -0500
Subject: Re: [PATCH]: 2.5.1pre9 change several if (x) BUG to BUG_ON(x)
To: mumismo@wanadoo.es (Jordi)
Date: Sun, 6 Jan 2002 14:48:13 +0000 (GMT)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020106123453.A27BF801C1@mumismo.wanadoo.es> from "Jordi" at Jan 06, 2002 01:34:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NEar-0005Ln-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, only that, even a trained monkey is able to make this patch, but i think
> is a good way to make people confortable with BUG_ON

Your patch looks wrong (ook ook! 8)) - if you build without BUG enabled you
don't make various function calls with your change. BUG_ON has the C nasty
assert() does that makes it a horrible horrible idea and its unfortunate
it got put in.

	BUG_ON(function(x,y))

ends up not causing function to be called when not debugging

The classic C mess people get into is similar with things like

	assert(x++ == 4);

