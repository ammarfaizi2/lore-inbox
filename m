Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVAaVBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVAaVBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVAaVAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:00:48 -0500
Received: from alg138.algor.co.uk ([62.254.210.138]:11157 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261373AbVAaVAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:00:06 -0500
Date: Mon, 31 Jan 2005 20:53:43 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [PATCH] Fix SERIAL_TXX9 dependencies
Message-ID: <20050131205342.GA11238@linux-mips.org>
References: <20050129131134.75dacb41.akpm@osdl.org> <200501301645.14069.arnd@arndb.de> <20050130165839.GB27703@linux-mips.org> <200501312123.11451.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501312123.11451.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 09:23:10PM +0100, Arnd Bergmann wrote:

> On Sünndag 30 Januar 2005 17:58, Ralf Baechle wrote:
> > Hmm...  Atushi sent me this new-style serial driver when I asked him for
> > replacements for the old style drivers in drivers/char/ so my undertanding
> > was it was a full replacement for all of them.  I'll check on the tx3912
> > and will try to send an update later today.
> 
> I just found that the version in -mm2 does not add the Makefile change, so
> you need this patchlet on top. If you haven't redone the patch yet, it might
> be better still to rename the file to txx9.o, as serial/serial_* is a bit
> redundant.

As for the TX3912 issue, there is no remaining user so that driver would
now be continuing to suffer from accelerated bitrot.  A rewrite to use
the drivers/serial infrastructure is relativly minor and so I and Atushi
Nemoto agree in that the old driver should stay removed, as my patch did
and therefore there was no need for rerolling the patch.  Akpm has in
the meantime sent the patches to Linus, so what's left would be renaming
the driver, as per your suggestion.

  Ralf
