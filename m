Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbUBBLeL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 06:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUBBLeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 06:34:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:37830 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265338AbUBBLeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 06:34:09 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 2 Feb 2004 12:34:00 +0100 (MET)
Message-Id: <UTC200402021134.i12BY0601230.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, vojtech@suse.cz
Subject: Re: 2.6 input drivers FAQ
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I think it's a bad idea to have the userspace tool know about the
> e0 thing at all. It should be just opaque numbers to it.

But how is the user to invent these opaque numbers?
She uses showkey -s to see what scancodes a key produces,
and then setkeycodes to assign a keycode to them.

> I don't have a problem with swapping the set3 table, if setkeycodes
> works reasonably now for scancodes above 128.

Above 128, yes. Above 256, no.
The interface is a char - 8 bits only.

(So, right now, NR_KEYS > 256 is not useful.)

Andries
