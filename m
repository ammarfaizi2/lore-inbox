Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270564AbRHITd1>; Thu, 9 Aug 2001 15:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270567AbRHITdR>; Thu, 9 Aug 2001 15:33:17 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:15123 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S270564AbRHITdE>;
	Thu, 9 Aug 2001 15:33:04 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Sampsa Ranta <sampsa@netsonic.fi>
Date: Thu, 9 Aug 2001 21:32:32 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Linux 2.4.7-ac9 (breaks ATM connect)
CC: <linux-kernel@vger.kernel.org>, laughing@shared-source.org
X-mailer: Pegasus Mail v3.40
Message-ID: <15F8646133@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Aug 01 at 22:27, Sampsa Ranta wrote:
> On Thu, 9 Aug 2001, Sampsa Ranta wrote:
> 
> > -           vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
> +           vci != ATM_VCI_ANY && vci >= 1 << dev->ci_range.vci_bits))

As these two are equivalent, probably just reverting patch back
to '>>' is easiest... Maybe that second one is more readable, but
I do not think.
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
