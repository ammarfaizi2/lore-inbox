Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272054AbTG2T6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272055AbTG2T6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:58:24 -0400
Received: from hera.cwi.nl ([192.16.191.8]:34202 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272054AbTG2T6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:58:19 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 29 Jul 2003 21:58:14 +0200 (MEST)
Message-Id: <UTC200307291958.h6TJwEL16979.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@osdl.org
Subject: Re: [PATCH] select fix
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

current:

        if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
                mask |= POLLOUT | POLLWRNORM;

Andries:

>> if (!tty->stopped &&

Manfred:

>> if (.. && tty->driver->write_room(tty) > 0)

Andrew:

> Any preferences?

I prefer Manfred's version.


Andries
