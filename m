Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289826AbSA2SzW>; Tue, 29 Jan 2002 13:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289831AbSA2SzN>; Tue, 29 Jan 2002 13:55:13 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:5388 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S289825AbSA2Sy5>;
	Tue, 29 Jan 2002 13:54:57 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Date: Tue, 29 Jan 2002 19:53:52 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.18-pre7 slow ... apm problem
CC: jdthood@mail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
        skraw@ithnet.com
X-mailer: Pegasus Mail v3.50
Message-ID: <104D80077517@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jan 02 at 20:36, Jeff Chua wrote:
> On Mon, 28 Jan 2002, Thomas Hood wrote:
> 
> > Suggestion: Try setting the idle_threshold to a higher value,
> > e.g., 98.  (The default value is 95.)
> 
> With 98, "ping localhost" on "guest" os showed 2 responses, then pause for
> few seconds, then response, ...
> 
> With 95, I got the 1st response, then nothing. 98 seems better, but still
> slow...
> 
> With 100, it's perfect.

I've got an idea - if you were saying that ping host->guest is fine,
but other way around it does not work. Can you apply 
ftp://platan.vc.cvut.cz/pub/vmware/vmware-ws-1455-update5.tar.gz
to your VMware 3.x? Stock vmware-3.x modules use netif_rx() instead
of netif_rx_ni(), and so network bottom half was not run under some 
conditions.

Patch also allows you to run VMware on 2.5.3-pre5, BTW.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    


