Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWFBDUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWFBDUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 23:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWFBDUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 23:20:22 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:54041 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751056AbWFBDUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 23:20:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KmS3+46etVU+HCwykYRpMbzDbjZGN6DfLTpLg/WcKVRDslufO4dgIbsFAodspMQmWByoiQWpMgBO0H6e1PiYLvy8hfBWwb31ebMjQaUOiisvZPh62rPu00jQFcapgc/Q0MIWshYEbfvKox3J0q7TEuae4r5GeUsVUPgcm+kMzSk=
Message-ID: <20f65d530606012020w5341171dua53c2d1fa52156d8@mail.gmail.com>
Date: Fri, 2 Jun 2006 15:20:21 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: IRQ sharing: BUG: spinlock lockup on CPU#0
Cc: linux-kernel@vger.kernel.org, "Hugh Dickins" <hugh@veritas.com>
In-Reply-To: <20060601195955.82141940.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530606011829n2ee1d76fg9d2c7bbc02a6a0aa@mail.gmail.com>
	 <20060601195955.82141940.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

Thank you very much for your reply.

> We've certianly screwed around with the mmapping of IO space and such
> things in recent months, and iirc 2.6.14 was somewhat in the middle of it
> all.
>
> Are you seeing the above problem on 2.6.16.x?
>

We used to see freezes more frequently (on both 2.6.16.18 and
2.6.14.2) before setting these tweaks:
- increase PCI latency of bttv device
- disable overlay on bttv driver
- enable HPET support for Character Devices
- disable "load DRI" in xorg.conf

After the tweaks, all 10 PCs have been under stress test for 48 hours,
and the first crash was on the 2.6.14.2. We will upgrade 3 more PCs to
2.6.16.18 today, to increase the probability of crashing on that
kernel.

Will keep you posted.

Regards
Keith
