Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266890AbRGQR6o>; Tue, 17 Jul 2001 13:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266891AbRGQR6e>; Tue, 17 Jul 2001 13:58:34 -0400
Received: from sncgw.nai.com ([161.69.248.229]:11954 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S266890AbRGQR6Z>;
	Tue, 17 Jul 2001 13:58:25 -0400
Message-ID: <XFMail.20010717110045.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B5476E0.EBC7CA12@watson.ibm.com>
Date: Tue, 17 Jul 2001 11:00:45 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Hubertus Frnake <frankeh@watson.ibm.com>
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency (FIX)_
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net, ak@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17-Jul-2001 Hubertus Frnake wrote:
> In an attempt to inline the code, somehow the tabs got lost. So here is the
> attached correct patch fo 2.4.5. Please try and let me know whether you
> see your problems disappear and/or others arise.
> The sketchy writeup is still the same.

Did You tried the patch ?
Maybe this could help :

+       next = cpu_resched(this_cpu);
+       if (next) {
+               cpu_resched(this_cpu) = NULL;
-               next = p;
+               goto found_next;
+       }




- Davide

