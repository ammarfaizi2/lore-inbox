Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSKMSYc>; Wed, 13 Nov 2002 13:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262303AbSKMSYc>; Wed, 13 Nov 2002 13:24:32 -0500
Received: from skyline.vistahp.com ([65.67.58.21]:51079 "HELO
	escalade.vistahp.com") by vger.kernel.org with SMTP
	id <S262258AbSKMSYa>; Wed, 13 Nov 2002 13:24:30 -0500
Message-ID: <20021113183354.13595.qmail@escalade.vistahp.com>
References: <20021113002529.7413.qmail@escalade.vistahp.com>
            <20021113153542.GB31016@lanl.gov>
In-Reply-To: <20021113153542.GB31016@lanl.gov>
From: "Brian Jackson" <brian-kernel-list@mdrx.com>
To: Eric Weigle <ehw@lanl.gov>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
Date: Wed, 13 Nov 2002 12:33:54 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19 appears to have that patch already applied except for changing the 
QLOGICFC_REQ_QUEUE_LEN to 255 in qlogicfc.h.  I made that change and 
rebooted with the new kernel. And I still have the same problem. I did 
however make sure none of the other hosts had the raid device started, and 
it still does the same thing, which pushes my suspicion back onto the 
drivers. 

 --Brian Jackson 

<snip>
> If those messages look like "no handle slots, this should not happen" and
> you're running a 2.4.x kernel there's a known problem with the qlogicfc
> driver locking up the machine under high load. It's been fixed in 2.5,
> but I don't think it's been back-ported yet. 
> 
> So, aside from the _other_ problems induced by shared storage, this might
> be biting you too. :) 
> 
> See:
> 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0209.0/0467.html 
> 
> 
> Thanks,
> -Eric 
> 
> -- 
> ------------------------------------------------
>  Eric H. Weigle -- http://public.lanl.gov/ehw/ 
> ------------------------------------------------
 
