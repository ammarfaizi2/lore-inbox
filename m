Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRJEXIq>; Fri, 5 Oct 2001 19:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274405AbRJEXIh>; Fri, 5 Oct 2001 19:08:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39947 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274368AbRJEXIW>; Fri, 5 Oct 2001 19:08:22 -0400
Subject: Re: Desperately missing a working "pselect()" or similar...
To: alex@pennace.org (Alex Pennace)
Date: Sat, 6 Oct 2001 00:13:39 +0100 (BST)
Cc: ecki@lina.inka.de (Bernd Eckenfels), linux-kernel@vger.kernel.org
In-Reply-To: <20011005190523.A6516@buick.pennace.org> from "Alex Pennace" at Oct 05, 2001 07:05:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pe9z-0007yv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The select system call doesn't return EINTR when the signal is caught
> prior to entry into select.

Your friend there is siglongjmp/sigsetjmp - the same problem was true
with old versions of alarm that did

	alarm(num)
	pause()

on a heavily loaded box.

Using siglongjmp cures that
