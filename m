Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVISP4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVISP4Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 11:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVISP4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 11:56:16 -0400
Received: from imap.gmx.net ([213.165.64.20]:2017 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932463AbVISP4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 11:56:15 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.13-mm2
Date: Mon, 19 Sep 2005 17:56:13 +0200
User-Agent: KMail/1.7.2
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050908053042.6e05882f.akpm@osdl.org> <200509182349.17632.daniel.ritz@gmx.ch> <Pine.LNX.4.61.0509190402500.16591@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509190402500.16591@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509191756.14777.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 September 2005 05.07, Hugh Dickins wrote:
> On Sun, 18 Sep 2005, Daniel Ritz wrote:
> > 
> > interesting. i'd say we get interrupt storms from usb which then hurt when
> > yenta has it's handler installed but usb has not. usb/hcd-pci.c frees the
> > irq on suspend...so it may be enough not to do that (survives suspend-to-ram
> > and suspend-to-disk here. yes, restore too :)
> 
> Will make no difference to my case: I have no USB,
> so don't even build drivers/usb/core/hcd-pci.o.

well, it's not supposed to do anything in your case. but maybe it
fixes rafaels case w/o this crappy yenta free_irq thing :)

-daniel
