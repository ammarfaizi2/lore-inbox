Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVBBTjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVBBTjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVBBTeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:34:50 -0500
Received: from asplinux.ru ([195.133.213.194]:10252 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S262750AbVBBTd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:33:28 -0500
Message-ID: <42012ACC.4090806@sw.ru>
Date: Wed, 02 Feb 2005 22:32:28 +0300
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

Hello Matt

Matt Domsch wrote:
> On Wed, Feb 02, 2005 at 09:42:02PM +0300, Vasily Averin wrote:
>>Marcelo,
>>
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


Could you fix it by additional patch? Or you going to prepare a new one?

Thank you,
	Vasily Averin, SWSoft Linux Kernel Team

