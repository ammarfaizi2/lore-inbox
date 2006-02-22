Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWBVLtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWBVLtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBVLtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:49:22 -0500
Received: from mail2.designassembly.de ([217.11.62.46]:58752 "EHLO
	mail2.designassembly.de") by vger.kernel.org with ESMTP
	id S1750949AbWBVLtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:49:21 -0500
Message-ID: <43FC4FBC.7030103@designassembly.de>
Date: Wed, 22 Feb 2006 12:49:16 +0100
From: Michael Heyse <mhk@designassembly.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: which one is broken: VIA padlock aes or aes_i586?
References: <43FB0746.5010200@designassembly.de> <20060222013137.GA844@gondor.apana.org.au>
In-Reply-To: <20060222013137.GA844@gondor.apana.org.au>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> I don't think this patch is your problem since it's part of the multiblock
> code which doesn't exist in 2.6.12 at all.  Of course the multiblock code
> itself could be buggy.  I'll take a look.

You're right, this doesn't make sense. I tried it with 2.6.15.4, and it works, 2.6.16-rc1 doesn't. In both cases no other AES algorithm than padlock was compiled into the kernel. I hope this helps.

BTW: 2.6.15 gives me a read performance increase of about 50% (hdparm -t) compared to 2.6.12, nice work!!

Michael
