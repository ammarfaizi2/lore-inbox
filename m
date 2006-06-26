Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWFZFXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWFZFXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 01:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFZFXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 01:23:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:2517 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932244AbWFZFXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 01:23:51 -0400
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Date: Mon, 26 Jun 2006 07:23:42 +0200
User-Agent: KMail/1.8
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <4492D5D3.4000303@atmos.washington.edu> <200606191724.31305.ak@suse.de> <20060625222243.GJ13255@w.ods.org>
In-Reply-To: <20060625222243.GJ13255@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606260723.43209.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I encountered the same problem on a dual core opteron equipped with a
> broadcom NIC (tg3) under 2.4. It could receive 1 Mpps when using TSC
> as the clock source, but the time jumped back and forth, so I changed
> it to 'notsc', then the performance dropped dramatically to around the
> same value as above with one CPU saturated. I suspect that the clock
> precision is needed by the tg3 driver to correctly decide to switch to
> polling mode, but unfortunately, the performance drop rendered the
> solution so much unusable that I finally decided to use it only in
> uniprocessor with TSC enabled.

2.6 is more clever at this than 2.4. In particular it does the timestamp
for each packet only when actually needed, which is relativelt rare.

Old experiences do not always apply to new kernels.

-Andi
