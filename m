Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUIBOwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUIBOwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUIBOwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:52:07 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:30902 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP id S268360AbUIBOso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:48:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16695.13000.673402.782323@gargle.gargle.HOWL>
Date: Thu, 2 Sep 2004 10:48:40 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Andrew Haninger <ahaning@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coolmax HD-211-COMBO with Prolific PL3507 chipset
In-Reply-To: <105c793f0409020709459a1e05@mail.gmail.com>
References: <105c793f0409020709459a1e05@mail.gmail.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew> I recently purchased a USB2+Firewire 2.5" portable harddrive
Andrew> enclosure. The enclosure is from Coolmax and is a
Andrew> HD-211-COMBO. The chipset is a Firewire and USB2 all-in-one
Andrew> deal called PL3507 from Prolific. I've read a bit about this
Andrew> chipset and few people (who are talking, at least) seem to
Andrew> have much success with it. I am strongly considering returning
Andrew> the enclosure for a refund.

Return it.  I've got a Prolific chipset enclosure and I can't make it
work properly under either Linux of my wife's Windows 2000 box.  I
paid's my money and took's my chances.  I'm a sucker.

Andrew> I have been able to get it to be detected and work on just one
Andrew> machine running Linux; an IBM xSeries 206 server running
Andrew> Fedora Core 2 (kernel 2.6.5). The device is rarely detected,
Andrew> but when it is, it seems to use the EHCI driver and it works
Andrew> fine until you unplug it and try to plug it back in. This
Andrew> behavior is not only limited to Linux, though. I have found
Andrew> just one Windows machine so far that detects it fine even if
Andrew> it is unplugged and plugged back in.

Detection was never the problem for me under either Linux or Windows,
it was that if you started writing data to it, it would choke and hang
completely.  You could run badblocks on the device without problems,
do a mkfs as well.  No problem.  Just try to write too much data (or
as I suspect in too large chunks) and it just wigged out and locked up
the drive.  At least under firewire it didn't take down the box.

It didn't work much better under USB2.0 (linux only testing though)
since it would write more data, but it would completely hang the
system.  

Andrew> So, while I'm very likely going to make use of Newegg's 30-day
Andrew> money-back guarantee, I thought I'd try to help the community
Andrew> out however I can. Not everyone has the luxury of being able
Andrew> to return their hardware for a refund. So if I can help
Andrew> someone who is developing a driver by testing it, I'd like to
Andrew> do that.  If anyone has any drivers that they are writing that
Andrew> might help to make this device work on Linux, I would be happy
Andrew> to be a guinea pig for your project.

The only thing I've seen which I haven't had time to work on yet,
thanks to a two year old little boy, is to take the iee1394 drives
from the 2.6.2 kernel and move them forward to the 2.6.8 kernel.  Some
people have reported success with the sbp2 driver in that case.  

In my case, I suspect that the prolific chipset sucks rocks. 

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
