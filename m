Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVKAQpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVKAQpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVKAQpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:45:12 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:45104 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750942AbVKAQpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:45:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=V70HJ/f3aGDmLn5j9Wxt+PqCTKfl4p+QaDxtTgm2LxKraRDvVIue2I7ms28O92zktHX4aGSVRAJMAK3QrQjhK4cpTAnT/DLZlgU9MJ3TXLnJXaL+rYTRrdxsXF2owPMFiN+/FBH6NgtpPqAcP9ed0rjp488drK8SNShgTgwPtXE=
Message-ID: <43679B8F.8000305@gmail.com>
Date: Tue, 01 Nov 2005 17:45:03 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>, "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems (SOLVED)
References: <53JVy-4yi-19@gated-at.bofh.it> <545a6-2GZ-17@gated-at.bofh.it>
In-Reply-To: <545a6-2GZ-17@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz ha scritto:
> On Mon, Oct 31, 2005 at 04:30:48PM +0100, Patrizio Bassi wrote:
> 
>>when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
>>file)
>>i hear noises, related to disk activity. more hd is used, more chicks
>>and ZZZZ noises happen.
>>
>>linux 2.4.x and windows has no problems, perfect.
> 
> 
>  I remeber similar problems with es1370 and OSS/ALSA driver. OSS were
> fine, ALSA produced noise.
>  It turned to be PCI latency timer issues. OSS driver changed it's value
> to working good values. ALSA didn't touch latency timer, and during hard
> disk activity sound stuttered.
>  Got rid of problem by running setpci -d CARD:ID latency_timer=40


seems now i got it **pretty** fixed.

what i did:
1) updated kernel to 2.6.14-git4
2) setted 100Hz instead of 250
3) setted latency to 0x40 (64) instead of old 0x20 (32)
4) disabled pci 2.1 in my bios.

i summed all solutions proposed by you all.

it seems much much better, even if problem is not completly disappeared.
i still get some ZzZ sounds, but they're so few i can declare problem fixed.

i'm gonna set fixed status to kernel and alsa bugzilla too.

Next step will be trying to get back to 250hz.

Thanks for all your help

Patrizio Bassi

