Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267582AbUIZMI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267582AbUIZMI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 08:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269516AbUIZMI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 08:08:58 -0400
Received: from smtp08.web.de ([217.72.192.226]:58558 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S267582AbUIZMI4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 08:08:56 -0400
Date: Sun, 26 Sep 2004 14:08:49 +0200
From: Gundolf Kiefer <gundolf.kiefer@web.de>
To: Jens Axboe <axboe@suse.de>, Christoph Bartelmus <lirc@bartelmus.de>
Cc: linux-kernel@vger.kernel.org
Subject: IRQ blocking when reading audio CDs
Message-ID: <20040926120849.GG3134@lilienthal>
Reply-To: gundolfk@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jens (& Christoph),

on my media PC (a Pentium II 350 MHz running Debian Woody with Kernel 
2.4.25), I have problems using LIRC 0.6.6 with a serial IR reveiver when at 
the same time some application (cdparanoia, xmms/Audio CD reader) is reading 
audio data from a CD.

After some testing and exploration of the LIRC source code, I figured out 
that during audio CD reading interrupts seem to be blocked for a longer time 
(in the order of milliseconds), while lirc_serial measures the exact time 
between two serial interrupts and thus relies on an accurate timing. In 
consequence, LIRC does not recognize the IR sequences, there are no errors 
reported. Assigning a high priority to the serial interrupt using "irq_tune" 
did not help.

Is there a way to make the audio CD read operations less blocking? Or does 
any of you know a different source of the problem I observed?

Thank you very much,

Gundolf


