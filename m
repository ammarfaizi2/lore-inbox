Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269244AbTCBRGs>; Sun, 2 Mar 2003 12:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269246AbTCBRGs>; Sun, 2 Mar 2003 12:06:48 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:1533 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S269244AbTCBRGr>; Sun, 2 Mar 2003 12:06:47 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Anders Gustafsson <andersg@0x63.nu>
Subject: Re: [PATCH] reduce large stack usage
Date: Sun, 2 Mar 2003 18:14:48 +0100
User-Agent: KMail/1.5
Cc: "Randy.Dunlap" <randy.dunlap@verizon.net>, linux-kernel@vger.kernel.org
References: <20030301071007$18ea@gated-at.bofh.it> <200303021413.PAA12289@post.webmailer.de> <20030302153805.GD27892@h55p111.delphi.afb.lu.se>
In-Reply-To: <20030302153805.GD27892@h55p111.delphi.afb.lu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303021814.48582.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 March 2003 16:38, Anders Gustafsson wrote:

> I'm also seeing crashes when unpacking the initramfs if I enlarge it so it
> takes more than a few (32kb) windows. I get crashes in a copy_from_user
> deep down the callchain when it is doing the sys_write to a file in ramfs.

That's slightly different from what I am experiencing on s390x. Here,
I get a panic 'length error' after initramfs is unzipped. It always
seems like one byte less is counted than actually is inside the
archive.
OTOH, the result of a stack overflow is usually undefined, so it might
also be this problem.

	Arnd <><
