Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbVH2UK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbVH2UK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVH2UK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:10:58 -0400
Received: from [212.76.84.38] ([212.76.84.38]:19975 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751497AbVH2UK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:10:57 -0400
From: Al Boldi <a1426z@gawab.com>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Subject: Re: Where is the performance bottleneck?
Date: Mon, 29 Aug 2005 23:10:39 +0300
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
In-Reply-To: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508292310.39903.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl wrote:
> Why do I only get 247 MB/s for writting and 227 MB/s for reading (from the
> bonnie++ results) for a Raid0 over 8 disks? I was expecting to get nearly
> three times those numbers if you take the numbers from the individual
> disks.
>
> What limit am I hitting here?

You may be hitting a 2.6 kernel bug, which has something to do with 
readahead, ask Jens Axboe about it! (see "[git patches] IDE update" thread)
Sadly, 2.6.13 did not fix it either.

Did you try 2.4.31?

--
Al
