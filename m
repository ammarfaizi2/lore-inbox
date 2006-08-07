Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWHGVJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWHGVJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWHGVJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:09:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:10031 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932297AbWHGVJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:09:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PfU820EKvfKCfINSoFn2O9dfT/tSlACzAwNEeJzWDibZo7CMqSeVRbhlu6BnvL9ShHLMJHclEKtyigRghz2QbkmveygUZVeGkvMPL8xmOz/tGKvACaQ5E5ILO1XEomXv4HYVUPP1i0hI6tt8ocd3ZuIxro/wY6OFiwhHE3BcfKU=
Message-ID: <44D7AC02.7060307@gmail.com>
Date: Mon, 07 Aug 2006 23:08:59 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jason Lunz <lunz@gehennom.net>
CC: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, pavel@suse.cz,
       linux-pm@osdl.org, linux-ide@vger.kernel.org
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com> <20060807162322.GA17564@knob.reflex>
In-Reply-To: <20060807162322.GA17564@knob.reflex>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz wrote:
> In gmane.linux.kernel, you wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
>> I tried it and guess what :)... swsusp doesn't work :@.
>>
>> This time I was able to dump process states with sysrq-t:
>> http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
>>
>> My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel prints is 
>> suspending device 2.0
> 
> Does it go away if you revert this?
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch

No change.

> That should only affect resume, not suspend, but it does mess around
> with ide power management. Is this maybe happening on the *second*
> suspend?

Nope, the first one.

>> -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
>> +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> 
> This looks suspicious. -mm does have several ide-fix-hpt3xx patches.

But hdc is not on the hpt3xx controller.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
