Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317768AbSGVURY>; Mon, 22 Jul 2002 16:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSGVURY>; Mon, 22 Jul 2002 16:17:24 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51865 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317768AbSGVURX>;
	Mon, 22 Jul 2002 16:17:23 -0400
Message-ID: <3D3C68D9.1020608@us.ibm.com>
Date: Mon, 22 Jul 2002 13:19:37 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Larson <plars@austin.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
References: <1027366468.5170.26.camel@plars.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> Encountered this first with Linux-2.5.25+rmap and it looks like the
> problem also slipped into 2.5.27.  The same machine boots fine with a
> vanilla 2.5.25 or 2.5.26, but gets this on boot with rmap.  The machine
> is an 8-way PIII-700.

I was hitting the same thing on a Netfinity 8500R/x370.  The problem 
was an old compiler (egcs 2.91-something).  It was triggered by a few 
different things, including kernprof and dcache_rcu.

-- 
Dave Hansen
haveblue@us.ibm.com

