Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbUKPK7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbUKPK7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbUKPK7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:59:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:56768 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261587AbUKPK7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 05:59:47 -0500
Message-ID: <4199DDF2.5040700@corscience.de>
Date: Tue, 16 Nov 2004 12:01:06 +0100
From: Simon Braunschmidt <braunschmidt@corscience.de>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>	 <84144f0204111602136a9bbded@mail.gmail.com>	 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <84144f020411160235616c529b@mail.gmail.com>
In-Reply-To: <84144f020411160235616c529b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:8519ad80e38159671026452e53963bc3
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pekka Enberg schrieb:
> Hi,
> 
> On Tue, 16 Nov 2004 11:20:22 +0100, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
>>>   - Breaks if CONFIG_PROC_FS is not enabled.
>>
>>Yes.  Would a device node be better?  Perhaps.  This way there's no
>>need to allocate a major/minor for a device.
> 
> 
> ...or fix your Kconfig to select procfs. :)
> 
> On Tue, 16 Nov 2004 11:20:22 +0100, Miklos Szeredi <miklos@szeredi.hu> wrote: 
> 
>>>   - Explicit casts are not needed when converting void pointers
>>>(found in various places).
>>
>>But they don't hurt either.  At least I can be sure to assign the
>>right kind of pointer.
> 
> 
> Hmm? The conversion is guaranteed by the standard which makes them
> redundant. 

And redundancy does hurt maintainability.

Naturally, it would be the other way around.
Sure you can write all your code in binary, or even better compressed, 
but i wouldnt maintain those beasts ;-)

  The have been
> patches to get rid of the existing casts so please don't introduce new
> ones.
> 
>                              Pekka

I vote for explicit casts, makes code more readable.

*duck*
Simon
