Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUGZOMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUGZOMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 10:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUGZOMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 10:12:41 -0400
Received: from ee.oulu.fi ([130.231.61.23]:40884 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263824AbUGZOMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 10:12:21 -0400
Date: Mon, 26 Jul 2004 17:11:28 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Florian Schirmer <jolt@tuxbox.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: b44: add 47xx support
Message-ID: <20040726141128.GA5435@ee.oulu.fi>
References: <200407232335.37809.jolt@tuxbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200407232335.37809.jolt@tuxbox.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 11:35:30PM +0200, Florian Schirmer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> this patch adds support for the BCM47xx device to the b44 driver. Please 
> apply.
> 
> BTW what happened to the 1GB DMA fix? The SiliconBackplane cores _are_ limited 
> to a 1GB DMA window so we need to take that into account. Any reason why 
> those patches where dropped?
Hiya

Looks good (well, won't be able to test that it doesn't break 4401 until
next week :-) ).

As for the 1GB patch going in, I sure hope they would (perhaps in a cleaned
up state, it might be more pretty if I just unconditionally enabled the
workaround and had a b44_alloc_skb() that tries a normal dev_alloc_skb and if
that gives something over 1GB retry with GFP_DMA...

A situation where it breaks even without 4g4g would help in getting the
patch in :-)

 
