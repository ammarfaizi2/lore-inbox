Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271230AbTHLXrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 19:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271239AbTHLXrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 19:47:55 -0400
Received: from fep04-svc.mail.telepac.pt ([194.65.5.203]:14278 "EHLO
	fep04-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S271230AbTHLXry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 19:47:54 -0400
Message-ID: <3F397CED.6060006@vgertech.com>
Date: Wed, 13 Aug 2003 00:49:01 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Ken Savage <kens1835@shaw.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: High CPU load with kswapd and heavy disk I/O
References: <200308121136.11979.kens1835@shaw.ca> <3F3943B9.7080700@vgertech.com> <200308121323.49081.kens1835@shaw.ca>
In-Reply-To: <200308121323.49081.kens1835@shaw.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Ken Savage wrote:
> On Tue August 12 2003 12:44, Nuno Silva wrote:

[..snip..]

> 
> AFTER:
> -----------
> 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  3710840832 2703040512 1007800320        0 427081728 522944512
> Swap: 2147467264 57257984 2090209280
> MemTotal:      3623868 kB
> MemFree:        984180 kB
> MemShared:           0 kB
> Buffers:        417072 kB


My guess is that this is the cause. LOWMEM pressure because of very 
large directories... Relating to this, linux-2.6.0-test3-mm1 has Ingo's 
4G/4G memory split. Can you try this kernel, enable 4G/4G feature, and 
report back?

Good luck,
Nuno Silva



