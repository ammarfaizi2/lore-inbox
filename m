Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVLIQqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVLIQqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 11:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVLIQqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 11:46:01 -0500
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:55268 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S964789AbVLIQqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 11:46:00 -0500
Message-ID: <4399B619.1090508@pin.if.uz.zgora.pl>
Date: Fri, 09 Dec 2005 17:51:37 +0100
From: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc5 and Alsa 1.0.10
References: <4399B195.9050801@pin.if.uz.zgora.pl> <Pine.LNX.4.61.0512091610160.24942@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0512091610160.24942@goblin.wat.veritas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins napisał(a):
> On Fri, 9 Dec 2005, Jacek Luczak wrote:
> 
>>I'm using now 2.6.15-rc5 kernel with latest Alsa 1.0.10 and I received a lot
>>of 'bad page state at free_hot_cold_page' (see example below) messages. Is
>>this kernel or alsa error?
>>
>>System:
>>Slackware Linux, GCC 3.4.4, Binutils 2.16.1.
>>CPU: Pentium 4 3Ghz HT
>>Sound card: CMI9880 (HDA)
>>
>>Dec  9 16:53:20 slawek kernel: Bad page state at free_hot_cold_page (in
>>process 'xmms', page c12da9c0)
>>Dec  9 16:53:20 slawek kernel: flags:0x80000414 mapping:00000000 mapcount:0
>>count:0
> 
> 
> I think that means you have a mismatch: that you're using core/memalloc.c
> from alsa-driver-1.0.10/alsa-kernel rather than from 2.6.15-rc5/sound.
> Applying the update below should eliminate your "Bad page state"s:
> I've no idea whether there are other mismatches, quite possibly not.
> 
> Hugh
> 

[snip]

Big thanks!!! It really helped.

	J.L.

