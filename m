Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWHBXYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWHBXYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 19:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHBXYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 19:24:10 -0400
Received: from mail.suse.de ([195.135.220.2]:38331 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932240AbWHBXYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 19:24:09 -0400
From: Andi Kleen <ak@suse.de>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: pccards are not detected
Date: Thu, 3 Aug 2006 01:23:54 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Roskin <proski@gnu.org>, Marcus Better <marcus@better.se>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200608021931.46058.daniel.ritz-ml@swissonline.ch> <1154551499.7714.13.camel@dv> <200608030102.48045.daniel.ritz-ml@swissonline.ch>
In-Reply-To: <200608030102.48045.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030123.54692.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ok, in other words:
> 2.6.16: end result: direct access; if direct doesn't work: pcibios
> 2.6.17: end result: pci bios (only direct if pcibios fails! )
> 2.6.17+patch: end result: direct access; if direct doesn't work: pcibios
> => net result is the same, but less code is executed, order is clear always.

Makes sense. PCI BIOS access is totally obsolete and should only be used
when everything else fails.


> btw. it's commit 92c05fc1a32e5ccef5e0e8201f32dcdab041524c
> ([PATCH] PCI: Give PCI config access initialization a defined ordering)
> that broke things on those laptops. cc'ing Andi...

It could have broken before where the order was essentially random.

-Andi
