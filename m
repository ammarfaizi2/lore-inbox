Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTE0J1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTE0J1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:27:44 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:45830 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263195AbTE0J1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:27:43 -0400
Date: Tue, 27 May 2003 13:40:17 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Willy Tarreau <willy@w.ods.org>
Cc: Jason Papadopoulos <jasonp@boo.net>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030527134017.B3408@jurassic.park.msu.ru>
References: <5.2.1.1.2.20030526232835.00a468e0@boo.net> <20030527045302.GA545@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030527045302.GA545@alpha.home.local>; from willy@w.ods.org on Tue, May 27, 2003 at 06:53:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 06:53:02AM +0200, Willy Tarreau wrote:
> I realized that a "idex=nodma" option is really lacking here. Shouldn't we
> disable IDE by default on Alpha at the moment, so that it at least boots ?

According to your .config and dmesg output, you didn't have the
chipset driver compiled in (CONFIG_BLK_DEV_ALI15X3).
Naturally, you would have troubles with DMA.

Ivan.
