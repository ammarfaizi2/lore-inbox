Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTKANRA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 08:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbTKANRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 08:17:00 -0500
Received: from open.nlnetlabs.nl ([213.154.224.1]:64522 "EHLO
	open.nlnetlabs.nl") by vger.kernel.org with ESMTP id S263803AbTKANQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 08:16:58 -0500
Date: Sat, 1 Nov 2003 14:17:33 +0100
From: Miek Gieben <miekg@atoom.net>
To: linux-kernel@vger.kernel.org
Subject: hard lockup with 2.6.0-test[789]
Message-ID: <20031101131733.GA4597@atoom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Vim/Mutt/Linux
X-Home: www.miek.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i'm experiencing hard lockups with the 2.6 kernel running on my firewall.

The machine:
pentium II, 
192 MB memory - did not run memtest though
uses reiserfs as / fs

replaced harddisk - old one had bad blocks
current harddisk: 4.3 maxtor

2.4.22 ran ok - no problem
2.6.0-test6 - ok	( haven't fully tested this though)
      test7 - crash
      test8 - crash
      test9 - crash

Problem:
crash after a warm reboot. Turning the machine off and then booting
it seems to make it run ok. But not always...

There is no oops, no nothing. The only thing I can do is reset the machine.
The role of the machine is to act as firewall.

It crashes after the boot - everything goes ok, until the prompt. Then
after a few seconds: a hard lock.

If it does _not_ crash (i've run crashme on the test9 once) it keeps going for
days and even longer (usally it runs until I update the kernel)

Right now i've switched / to another partition using ext3. It _looks_ like it
doesn't crash anymore, so my suspicion is that it is reiserfs related, but i'm
only guessing here.

My server also has a reiserfs partition (though not as /) and it has no problems
with it...

What can I do to find the cause of it? I've already disabled dma but that seems
to make no difference. 

grtz Miek
