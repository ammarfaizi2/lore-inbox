Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752089AbWFLQZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbWFLQZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbWFLQZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:25:36 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:20240 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1752087AbWFLQZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:25:35 -0400
Message-ID: <448D9577.3040903@shadowen.org>
Date: Mon, 12 Jun 2006 17:25:27 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Franck <vagabon.xyz@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SPARSEMEM] confusing uses of SPARSEM_EXTREME (try #2)
References: <448D1117.8010407@innova-card.com>
In-Reply-To: <448D1117.8010407@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franck Bui-Huu wrote:
> Is it me or the use of CONFIG_SPARSEMEM_EXTREME is really confusing in
> mm/sparce.c ? Shouldn't we use CONFIG_SPARSEMEM_STATIC instead like
> the following patch suggests ?
> 
> -- >8 --
> Subject: [PATCH] Remove confusing uses of SPARSEMEM_EXTREME
> 
> CONFIG_SPARSEMEM_EXTREME is used in sparce.c whereas
> CONFIG_SPARSEMEM_STATIC seems to be more appropriate.
> 
> Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com> 

In my mind the positive option is selecting for code supporting EXTREME
so it seems to make sense to use that option.  Perhaps the confusion
comes from a lack of comments there to say that the else case is STATIC.

-apw
