Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWHENnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWHENnM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 09:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWHENnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 09:43:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45953 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932234AbWHENnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 09:43:11 -0400
Subject: Re: hda=none hda=noprobe is ignored by <=2.6.15-26
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: koko <citizenr@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3df49b7b0608041529k274c3c38labe52259cee555db@mail.gmail.com>
References: <3df49b7b0608041529k274c3c38labe52259cee555db@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 05 Aug 2006 15:02:49 +0100
Message-Id: <1154786569.10971.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-08-05 am 00:29 +0200, ysgrifennodd koko:
> So why kernel probes IDE channel I just ordered him to IGNORE?

hda=noprobe or failing that hda=none ought to be sufficient. If you need
the latter make sure your CMOS drive settings are correct too.

> [17179577.060000] Probing IDE interface ide0...
> [17179611.848000] ide0: Wait for ready failed before probe !
> [snip]
> 
> almost a minute here :/

That indicates a possible pull-up resistor problem too. The kernel is
seeing the cable as having a drive on it that is not responding so waits
the required spin up time.


