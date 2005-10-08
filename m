Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVJHVWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVJHVWR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 17:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVJHVWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 17:22:16 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:6420 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751135AbVJHVWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 17:22:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tnG28Jr5HlEGBgYNjmyw2SeLPeeDEgoX4rwq3b2Pf0eegGyqpMJhRQ6znMj5MqfbChJONLPs8dX6ZEUODmjF2QSw9Cx7jxDCnD3u3g2O8IdrlE9lP8GNJGHQ0hO9+Nryf6mqaq3mdX3ZkR5iPKjZBHDRCqaeZKPzh5QGRmz/suc=
Message-ID: <4348387B.7000608@gmail.com>
Date: Sun, 09 Oct 2005 05:22:03 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Modular i810fb broken, partial fix
References: <200510071547.14616.bero@arklinux.org> <4347A1E7.2050201@pol.net> <1308gutgj0dx4$.1ie66adezdlua$.dlg@40tude.net> <4347C393.5090304@gmail.com> <1pfuqilz0eim.1n6ig5c3s2r3.dlg@40tude.net>
In-Reply-To: <1pfuqilz0eim.1n6ig5c3s2r3.dlg@40tude.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> On Sat, 08 Oct 2005 21:03:15 +0800, Antonino A. Daplas wrote:
> 
>> Giuseppe Bilotta wrote:
>>> On Sat, 08 Oct 2005 18:39:35 +0800, Antonino A. Daplas wrote:
>>>
>>>> Bernhard Rosenkraenzer wrote:
>>>>> Hi,
>>>>> i810fb as a module is broken (checked with 2.6.13-mm3 and 2.6.14-rc2-mm1).
>>>>> It compiles, but the module doesn't actually load because the kernel doesn't 
>>>>> recognize the hardware (the MODULE_DEVICE_TABLE statement is missing).
>>>>> The attached patch fixes this.
>>>>>
>>>>> However, the resulting module still doesn't work.
>>>>> It loads, and then garbles the display (black screen with a couple of yellow 
>>>>> lines, no matter what is written into the framebuffer device).
>>>> Did you compile CONFIG_FRAMEBUFFER_CONSOLE statically, or did a modprobe fbcon?
>>>> Does i810fb work if compiled statically?
>>> Since this is *really* coming out often: is there a specific reason
>>> why the fb modules do not depend on fbcon?
>>>
>> Some need fbdev only, without fbcon, ie, embedded.
> 
> And does fbcon make sense *without* fbdevs?
> 

You can load fbcon only if you also load the core fb layer.  But without
any registered fbdevs, fbcon just stays in memory and will not take over
the console.

Tony
