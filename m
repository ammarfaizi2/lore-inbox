Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbTEBAAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTEBAAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:00:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:53521 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262797AbTEBAAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:00:16 -0400
Date: Fri, 2 May 2003 02:10:50 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Willy TARREAU <willy@w.ods.org>, hugang <hugang@soulinfo.com>,
       linux-kernel@vger.kernel.org, akpm@digeo.com, dphillips@sistina.com
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030502001050.GA25789@alpha.home.local>
References: <200304300446.24330.dphillips@sistina.com> <20030501225321.6b30e8dc.hugang@soulinfo.com> <20030501171627.GA1785@pcw.home.local> <200305020127.26279.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305020127.26279.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 01:27:16AM +0200, Thomas Schlichter wrote:
 
> So for me the table version seems to be the slowest one. The BSRL instruction 
> on the K6-III seems to be very slow, too. The tree and my shift version are 
> faster than the original version here...
> 
> That someone else can test my fls_shift version I'll provide it here again:

That's interesting Thomasr. I get 18.4 s on the Athlon here vs 32.3 for Daniel's
(I have broken my function at the moment so I cannot re-bench it right now, but
it should be near Daniel's). At first, I thought you had coded an FFS instead of
an FLS. But I realized it's valid, and is fast because one half of the numbers
tested will not even take one iteration.

Regards,
Willy

