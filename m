Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbSKSSgO>; Tue, 19 Nov 2002 13:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbSKSSgN>; Tue, 19 Nov 2002 13:36:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34308 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267120AbSKSSgF>;
	Tue, 19 Nov 2002 13:36:05 -0500
Message-ID: <3DDA8632.3090105@pobox.com>
Date: Tue, 19 Nov 2002 13:42:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, arashi@arashi.yi.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] mii module broken under new scheme
References: <7FA0E2B042A@vcnet.vc.cvut.cz>
In-Reply-To: <7FA0E2B042A@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> Rusty told me that it is intentional. Add
>
> no_module_init;
>
> at the end of module. He even sent patch which fixes dozen of such
> modules (15 I had on my system...) to Linus, but it get somehow lost.



I know.

I'm hoping Linus intentionally dropped it, because it's silly.  See the 
other message I just posted.  It's redundant because the module loader 
can obviously figure out there is no init nor exit routine.  It's just 
like EXPORT_NO_SYMBOLS: redundant and obvious.

<rant>
Why the fsck is Rusty's new module code requiring all these driver 
changes???  Note from your message above that there are "dozens" of 
modules which worked just fine, but now they need to be changed under 
Rusty's new system.

I thought Rusty's new stuff was going to cause minimal to no driver 
breakage.  You know, at kernel summit there was the thought that we 
should just disable module -un-loading.  I wish he had stuck with that 
simple idea, plus module_param [because MODULE_PARM obviously sucks].
</rant>

	Jeff, grumbling driver author who sees his drivers diverging and 
breaking...






