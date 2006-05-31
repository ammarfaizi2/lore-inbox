Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWEaA6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWEaA6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 20:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWEaA6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 20:58:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:454 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932549AbWEaA57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 20:57:59 -0400
Date: Tue, 30 May 2006 20:57:29 -0400 (EDT)
Message-Id: <20060530.205729.73666677.davem@redhat.com>
To: g.liakhovetski@gmx.de
Cc: htejun@gmail.com, nico@cam.org, axboe@suse.de,
       James.Bottomley@SteelEye.com, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mattjreimer@gmail.com
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.60.0605302301280.6213@poirot.grange>
References: <Pine.LNX.4.64.0605291509370.11290@localhost.localdomain>
	<447C2A48.1050200@gmail.com>
	<Pine.LNX.4.60.0605302301280.6213@poirot.grange>
X-Mailer: Mew version 4.2.52 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The IDE string ops need to flush the cache.  We've been doing that
on sparc64 for more than 5 years...  Otherwise, PIO transfers do
not "behave" like DMA.


