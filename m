Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUIANO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUIANO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUIANO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:14:58 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:10768 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S266473AbUIANOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:14:45 -0400
Message-ID: <49210.194.237.142.7.1094044484.squirrel@194.237.142.7>
In-Reply-To: <Pine.GSO.4.58.0409011341140.15681@waterleaf.sonytel.be>
References: <20040831192642.GA15855@mars.ravnborg.org>
    <Pine.GSO.4.58.0409011341140.15681@waterleaf.sonytel.be>
Date: Wed, 1 Sep 2004 15:14:44 +0200 (CEST)
Subject: Re: kbuild: Support LOCALVERSION
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Ian Wienand" <ianw@gelato.unsw.edu.au>,
       "Christoph Hellwig" <hch@lst.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 31 Aug 2004, Sam Ravnborg wrote:
>> This allows one to put a short string in localversion identifying this
>> particular configuration "-smpacpi", or to identify applied patches
>> to the source "-llat-np".
>>
>> More specifically:
>> $(srctree)/localversion-lowlatency contains "-llat"
>> $(srctree)/localversion-scheduler-nick constins "-np"
>>
>> $(objtree)/localversion contains "-smpacpi"
>>
>> Resulting KERNELRELEASE would be:
>> 2.6.8.rc1-smpacpi-llat-np
>
> Wouldn't it make more sense the other way around (i.e. first append
> $(srctree)/localversion-*, then append $(objtree)/localversion*)?
>
> Hmm, from a second thought the order depends on what your most interested
> in:
> building kernels with different configs, or building kernels from
> different
> sources.
>
My rationale was that the config used would vary more than the source.
I also thought about sorting the files - but if Andrew for example
start using this it would maybe come in the middle.
Therefore this more simple approach.

   Sam


