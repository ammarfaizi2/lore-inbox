Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267985AbUHTNsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267985AbUHTNsU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUHTNsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:48:20 -0400
Received: from mail.kamp-dsl.de ([195.62.99.42]:22994 "HELO dsl-mail.kamp.net")
	by vger.kernel.org with SMTP id S267473AbUHTNrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:47:19 -0400
Message-ID: <412600FB.6000700@ti.uni-trier.de>
Date: Fri, 20 Aug 2004 15:47:39 +0200
From: Jochen Bern <bern@ti.uni-trier.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040413 Debian/1.6-5 Mnenhy/0.6.0.102
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Timer-ing ATKBD Communication?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone please give me a hint (function name, pointer to example 
code or docs) how to accomplish the following?

I'm trying to implement additional communication between kernel and a 
PS/2 connected AT keyboard. What I have right now (in 2.6.4-52 so far) is:
-- one additional branch in
    drivers/input/keyboard/atkbd.c::atkbd_interrupt() that recognizes
    the keyboard's (different) responses, processes them, and keeps
    them away from the normal atkbd_interrupt() processing
-- another additional branch that, if a special key was pressed, uses
    atkbd_sendbyte() to initiate the communication. (Note that this
    being hooked into atkbd_interrupt() provides me with direct access
    to struct atkbd *atkbd to fill the first param of atkbd_sendbyte().)
The actual communication seems to work (awaiting kernel upgrade and 
stress testing), but I need part of the communication initiated at 
regular intervals (about every second or so) instead of keying off other 
keyboard activity ...

TIA,
								J. Bern
