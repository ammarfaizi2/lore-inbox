Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUBORem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 12:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUBORem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 12:34:42 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:9373 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265118AbUBORek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 12:34:40 -0500
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
From: Christophe Saout <christophe@saout.de>
To: Michal Kwolek <miho@centrum.cz>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <402A4B52.1080800@centrum.cz>
References: <402A4B52.1080800@centrum.cz>
Content-Type: text/plain
Message-Id: <1076866470.20140.13.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 18:34:31 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I've got a reproducible oops when using cryptoloop on vanilla 2.6.0,
> 2.6.1 and 2.6.2 (2.4.* works fine).
> [also reported a deadlock while trying loop-aes]

could you try dm-crypt? It uses the device-mapper instead of the loop
device but should be compatible (uses cryptoapi too). It's going to be
added to the kernel soon I hope.

You can find a patch on http://www.saout.de/misc/ against the vanilla
kernel (dm-crypt.diff), I just rediffed it against linux 2.6.2.

You need the dmsetup tool from the device-mapper package to set up
encryption. There's also a shell script called cryptsetup on the page
that wraps around dmsetup. It requires the hashalot program.

It shouldn't oops. But if the deadlock you were seeing didn't come from
loop-aes it might also show up here. If you're willing to test - let me
know. :)


