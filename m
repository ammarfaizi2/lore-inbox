Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWGMHMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWGMHMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWGMHMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:12:52 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:5321 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751496AbWGMHMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:12:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QLH/7G9hq/BLA3lvkqYseeP1+Q0tL4pL0HTVA1xqfWtXfV1Z6M9vfVd5Suvm8IJG7a4ndCb/Rn0SZJSrsL0PXF0pumrqD3Y5vhBL5hpJYjWqpbalYVOslu8LmrpGM49Ynwk1YaNj5MVlZVO27Ztx02uTrh0mP+Jx597ffBnFEW0=
Message-ID: <3aa654a40607130012h2c18f45av4d05244facaa01a1@mail.gmail.com>
Date: Thu, 13 Jul 2006 00:12:50 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Rumi Szabolcs" <rumi_ml@rtfm.hu>
Subject: Re: Athlon64 + Nforce4 MCE panic
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060713090146.690d4759.rumi_ml@rtfm.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060713090146.690d4759.rumi_ml@rtfm.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/06, Rumi Szabolcs <rumi_ml@rtfm.hu> wrote:
> Hello!
>
> Tonight I had a kernel panic (full hang) with the following on the console:
>
> CPU 0: Machine Check Exception: 0000000000000004
> Bank 4: b200000000070f0f
> Kernel panic - not syncing: CPU context corrupt
>
> I tried to decode this:
>
> # ./parsemce -e 0000000000000004 -b 4 -s b200000000070f0f -a 0
> Status: (4) Machine Check in progress.
> Restart IP invalid.
> parsebank(4): b200000000070f0f @ 0
>         External tag parity error
>         CPU state corrupt. Restart not possible
>         Error enabled in control register
>         Error not corrected.
>         Bus and interconnect error
>         Participation: Generic
>         Timeout:
>         Request: Generic error
>         Transaction type : Invalid
>         Memory/IO : Other
>
> # echo 'CPU 0: Machine Check Exception: 0000000000000004 Bank 4: b200000000070f0f' | mcelog --ascii --k8
> HARDWARE ERROR. This is *NOT* a software problem!
> Please contact your hardware vendor
> CPU 0 4 northbridge   Northbridge Watchdog error
>        bit57 = processor context corrupt
>        bit61 = error uncorrected
>   bus error 'generic participation, request timed out
>       generic error mem transaction
>       generic access, level generic'
> STATUS b200000000070f0f MCGSTATUS 4
>
> I've been searching for and found some additional info, it
> looks like I'm not the first experiencing this problem:
>
> http://kerneltrap.org/node/4993
>
> Here ^^^ it is suggested that there was some thread about A64 MCEs
> on LKML but I failed to find it so I decided to post... sorry if
> it's redundant.
>
> The kernel is 2.6.16-gentoo-r9 and the CPU is an A64 "Venice" 3500+
> I can post further hw/sw environment information if req'd.

I had this same problem, search the lkml if you're interested in
investigating this further, I had the problem, was told it was
hardware, replaced my motherboard with the same model, the MCE
continued to occur, replaced the motherboard with a different model
and the MCE went away. It was some Biostar IIRC, but you can check the
archives if you really want to find out.

Good luck
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
