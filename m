Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268250AbUHYSsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268250AbUHYSsR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268273AbUHYSsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:48:16 -0400
Received: from [195.23.16.24] ([195.23.16.24]:25779 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268286AbUHYSqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:46:55 -0400
Message-ID: <412CDE9D.3090609@grupopie.com>
Date: Wed, 25 Aug 2004 19:46:53 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825173941.GJ5414@waste.org>
In-Reply-To: <20040825173941.GJ5414@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.29; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Wed, Aug 25, 2004 at 05:04:46AM +0100, pmarques@grupopie.com wrote:
> 
>>As always, comments, suggestions, flames will be greatly appreciated :)
> 
> 
> Please post patches inline so they're easier to comment on.
> Attachments are a nuisance.

Sorry about that. I've had problems in the past with my email client 
word wrapping patches, so to be sure the patch goes untouched I sent it 
this way.

Since I've changed email client since then, next time I'll try inlining 
again.

> Am I correct that this is completely replacing stem compression with
> your substring dictionary approach?

Yes, you are correct.

Right now I'm working on making the proc interface more eficient by 
removing all the seq_file stuff, that was needed because of the O(n) 
lookup time we had previously.

Not using seq_file with stem decompression would make a simple "cat 
/proc/kallsyms" to be O(n^2).

Bets regards,

-- 
Paulo Marques - www.grupopie.com
