Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRLLNSi>; Wed, 12 Dec 2001 08:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279778AbRLLNS2>; Wed, 12 Dec 2001 08:18:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56844 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279313AbRLLNSO>; Wed, 12 Dec 2001 08:18:14 -0500
Subject: Re: [PATCH] /proc/net/dev counter fix, linux-2.5.0
To: miipekk@ihme.org (Miika Pekkarinen)
Date: Wed, 12 Dec 2001 13:27:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112121210500.972-100000@ihme.org> from "Miika Pekkarinen" at Dec 12, 2001 12:12:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16E9Pq-00014Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have made a patch to fix the counter values in /proc/net/dev. The
> problem was that the tx_bytes and rx_bytes will reset when ~4GB is
> transferred. This patch has been tested to work with linux-2.5.0 but it
> should work on all 2.4.* kernels. Also it should work with most of the
> interface cards but not all yet.

It's something we've always avoided doing. A long long is expensive to
update and not an atomic type on things like the x86. The firewalling 
facilities let you collect 64bit accounting data if you need it
