Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbUBOOrX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 09:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUBOOrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 09:47:22 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:960 "EHLO mail4.ewetel.de")
	by vger.kernel.org with ESMTP id S264927AbUBOOrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 09:47:21 -0500
Date: Sun, 15 Feb 2004 15:48:42 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
Message-ID: <Pine.LNX.4.58.0402151545030.443@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>    Then I did unicode_stop.  Guess what: it put the display back in
>>    iso-8859-1 for that virtual terminal, but the keyboard remained
>>    stuck in UTF-8 for _all_ virtual terminals.
> kbd_mode -a to reset to ASCII mode.

And as I just figured out, loadkeys has to be invoked again, also.

I can go to utf-8 with:

	setfont lat0-16
	kbd_mode -u
	loadkeys de-latin1-nodeadkeys

and return to latin-1 with:

	setfont lat1-16
	kbd_mode -a
	loadkeys de-latin1-nodeadkeys

Without the loadkeys after returning to latin-1 mode, I can no longer
input umlauts and other special characters correctly.

-- 
Ciao,
Pascal
