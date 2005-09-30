Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbVI3Whl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbVI3Whl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbVI3Whl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:37:41 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:15535 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1030484AbVI3Whl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:37:41 -0400
Message-ID: <433DBE33.7090700@vc.cvut.cz>
Date: Sat, 01 Oct 2005 00:37:39 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch] x86, x86_64: fix cpu model for family 0x6
References: <20050929190419.C15943@unix-os.sc.intel.com> <433D391A.70607@vc.cvut.cz> <20050930112310.A28092@unix-os.sc.intel.com> <200510010002.16382.ak@suse.de> <20050930152358.D28092@unix-os.sc.intel.com>
In-Reply-To: <20050930152358.D28092@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Sat, Oct 01, 2005 at 12:02:16AM +0200, Andi Kleen wrote:
> 
>>I applied an earlier mix of your original one and Petr's suggestions. Hope 
>>it's ok. 
> 
> 
> Andi I prefer to follow the SDM guidelines. Who knows if future families
> comeup with a different rule or use/initialize these extended model/family
> bits differently. I am just being paranoid.

And which chance is bigger - that such hypothetical processor will use
extended model, and your code will get incorrect answer everywhere, or
that such hypothetical processor will not use extended model, and your
code will be right?

>>+		if (c->x86 >= 0xf) 
> 
> 
> And also you have a typo. It should be 0x6.

It is intentional.  Maybe it could do BUG_ON(c->x86 < 0xf).
								Petr

