Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131814AbQK3JRl>; Thu, 30 Nov 2000 04:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131882AbQK3JRc>; Thu, 30 Nov 2000 04:17:32 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:23961 "EHLO
        smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
        id <S131814AbQK3JRU>; Thu, 30 Nov 2000 04:17:20 -0500
Message-ID: <3A2613D5.AE8A00B8@haque.net>
Date: Thu, 30 Nov 2000 03:46:13 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@wirex.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Keyspan USB PDA adapter && test12pre3 hang
In-Reply-To: <3A25EB64.3462AE4D@haque.net> <20001129234420.A7196@wirex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That fixed it. Thanks

Greg KH wrote:
> Are you using the usb-uhci host driver?
> 
> If so, the following fix from Georg Acher should do the trick:
> 
> -----
> Replace line 275 (insert_td())
> qh->hw.qh.element = virt_to_bus (new) | UHCI_PTR_TERM;
> by
> qh->hw.qh.element = virt_to_bus (new) ;
> 
> -----
> 
> Let me (and the list) know if this doesn't fix your problem.
> 
> greg k-h
> 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
