Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264935AbSJVWXw>; Tue, 22 Oct 2002 18:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSJVWXw>; Tue, 22 Oct 2002 18:23:52 -0400
Received: from rth.ninka.net ([216.101.162.244]:14737 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S264935AbSJVWXv>;
	Tue, 22 Oct 2002 18:23:51 -0400
Subject: Re: feature request - why not make netif_rx() a pointer?
From: "David S. Miller" <davem@rth.ninka.net>
To: Slavcho Nikolov <snikolov@okena.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00b201c27a0e$3f82c220$800a140a@SLNW2K>
References: <00b201c27a0e$3f82c220$800a140a@SLNW2K>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 15:40:51 -0700
Message-Id: <1035326451.4817.15.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 14:01, Slavcho Nikolov wrote:
> Non GPL modules that want to attach themselves between all L2 drivers and
> upper layers would not have to incur a performance loss if netif_rx() is
> made a

What you are suggesting can only result in illegal binary-only
modules.

If you override netif_rx(), you are by definition implementing a derived
work of the kernel reimplementing core functionality, thus your binary
only driver is not abiding by the GPL and you are on very shaky legal
ground.

It isn't exported for a reason, there is legitimate use of it from
modules.

