Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWFBSGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWFBSGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 14:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWFBSGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 14:06:09 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:29147 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750808AbWFBSGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 14:06:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=dxaPO4GC05PmT31AZmzTNkUKzoZEFuVblOo09Z3BmMI4+apn/9ZzdqMv3NrqW9dU2YBeAcmfw1n7SWvjLv+S+TlYv0nFcMDUQCWG0+FzPK7KjXcox9s3YMUKUwDkmSjmWCY5NAFCWaBweDmIQ7CJjr2S5ueFR43A3490m3iiNIs=
Message-ID: <986ed62e0606021106j45721e54v136acac5e45f37af@mail.gmail.com>
Date: Fri, 2 Jun 2006 11:06:07 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
	 <20060601183836.d318950e.akpm@osdl.org>
	 <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
	 <20060602142009.GA10236@elte.hu>
	 <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com>
X-Google-Sender-Auth: e5c00c19e9ef0fe4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/06, Barry K. Nathan <barryn@pobox.com> wrote:
> I'm doing building the kernel, but I haven't been able to boot it yet:

That should be "done building".

> This system boots the kernel off floppy disks, and under
> 2.6.17-rc5-mm2, the floppy drive no longer works! The disk spins but
> the kernel can't read any of the disk's sectors, even for other
> known-working floppies. I'll have to boot back into 2.6.17-rc4-mm3

I notice that I get messages like this in dmesg with each disk access:

[24067.495591]
[24067.496740] floppy driver state
[24067.497874] -------------------
[24067.499009] now=2371176 last interrupt=2370874 diff=302 last called
handler=c021c69b
[24067.501195] timeout_message=redo fd request
[24067.502286] last output bytes:
[24067.503500]  8 80 2287517
[24067.504716]  8 80 2287517
[24067.505960]  8 80 2287517
[24067.507173]  8 80 2287517
[24067.508347]  8 80 2287972
[24067.509480]  8 80 2287972
[24067.510611]  8 80 2287972
[24067.511745]  8 80 2287972
[24067.512876]  8 80 2288278
[24067.514007]  8 80 2288278
[24067.515138]  8 80 2288278
[24067.516281]  8 80 2288278
[24067.517403]  8 80 2343834
[24067.518456]  8 80 2343834
[24067.519705]  8 80 2343834
[24067.520910]  8 80 2343834
[24067.522099]  8 80 2370874
[24067.523290]  8 80 2370874
[24067.524481]  8 80 2370874
[24067.525638]  8 80 2370874
[24067.526772] last result at 2370874
[24067.527906] last redo_fd_request at 2370876
[24067.529041]
[24067.530174] status=80
[24067.531305] fdc_busy=1
[24067.532436] floppy_work.func=c021a164
[24067.533570] cont=c0310e98
[24067.534651] current_req=dfe9a7d0
[24067.535747] command_status=-1
[24067.536937]
[24067.538133] floppy0: floppy timeout called
[24067.539345] end_request: I/O error, dev fd0, sector 0

The various numbers sometimes change however. I could provide a few
more samples if need be.
-- 
-Barry K. Nathan <barryn@pobox.com>
