Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVBBUJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVBBUJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVBBUIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:08:04 -0500
Received: from asplinux.ru ([195.133.213.194]:28430 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S262647AbVBBTwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:52:17 -0500
Message-ID: <42012F0A.7080704@sw.ru>
Date: Wed, 02 Feb 2005 22:50:34 +0300
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021224
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrey Melnikov <temnota+kernel@kmv.ru>, linux-kernel@vger.kernel.org,
       Atul Mukker <Atul.Mukker@lsil.com>,
       Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
Subject: Re: [PATCH] Prevent NMI oopser
References: <41F5FC96.2010103@sw.ru> <20050131231752.GA17126@logos.cnet> <42011EFA.10109@sw.ru> <20050202190626.GB18763@lists.us.dell.com>
In-Reply-To: <20050202190626.GB18763@lists.us.dell.com>
X-Enigmail-Version: 0.70.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> On Wed, Feb 02, 2005 at 09:42:02PM +0300, Vasily Averin wrote:
>>This is megaraid2 driver update (2.10.8.2 version, latest 2.4-compatible
>>version that I've seen), taken from latest RHEL3 kernel update. I
>>believe it should prevent NMI in abort/reset handler.
> 
> Thanks Vasily, I was just looking at this again yesterday.
> 
> You'll also find that because the driver doesn't define its inline
> functions prior to their use, newest compilers refuse to compile this
> version of the driver.  Earlier compilers just ignore it and don't
> inline anything.
> 
> As a hack, one could #define inline /*nothing*/ in megaraid2.h to
> avoid this, but it would be nice if the functions could all get
> reordered such that inlining works properly, and the need for function
> declarations in megaraid2.h would disappear completely.

Could you fix it by additional fix? Or you going to release new driver 
version for 2.4 kernels?

Thank you,
	Vasily Averin

