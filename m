Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUAES0C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUAES0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:26:02 -0500
Received: from ee.oulu.fi ([130.231.61.23]:29833 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S265244AbUAESZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:25:57 -0500
Date: Mon, 5 Jan 2004 20:25:54 +0200
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: aeb@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Annoying 2.4 -> 2.6 keycode change
Message-ID: <20040105182554.GA23617@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to point out http://bugme.osdl.org/show_bug.cgi?id=1637 (and my
earlier #1140 which got closed as "DOCUMENTED", but I have no idea what
documentation this refers to), which describes a behaviour
change from 2.4 to 2.6 on some European USB keyboards, where the key next to
enter (' and * on a finnish layout, \| on US) gets mapped to 84 by
hid-input.c, which is defined as Last_Console or SAK by just about all of
the keymaps in the kbd package. 

XFree86 was fine until 2.6.1-rc1 (with "2.4 compatibility fixes") after
which it started to handle the key as "Print Screen"

So, either the hid-input (and usbkbd?) mapping or most of the keyboard layouts of kbd and
XFree86 need to be fixed.
