Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281778AbRKUMbI>; Wed, 21 Nov 2001 07:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281775AbRKUMa6>; Wed, 21 Nov 2001 07:30:58 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:16646 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S281766AbRKUMan>;
	Wed, 21 Nov 2001 07:30:43 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 21 Nov 2001 13:29:51 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: New ac patch???
CC: marcel@mesa.nl (Marcel J.E. Mol), roy@karlsbakk.net (Roy Sigurd Karlsbakk),
        linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <9CF08CC6C77@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 01 at 11:12, Alan Cox wrote:
> > > Not exaclty. It is a 48Gig drive in a dell inspiron 8000. I think it is
> > > IBM but the logs do not show a brandname. I can try open up the case tonight
> > > if you want to know for sure?
> > 
> > It's an IBM IC25T048ATDA05-0 to be precise.
> 
> Thanks. It seems IBM laptop drives are the ones that specifically need this
> fix. That ties in with the windows 98 reports/microsoft fixes.

If it will go into mainstream, please change it to config option or
something like that. I'm doing 

for a in /dev/hd[a-z]; do hdparm -Y $a; done

in my poweroff script. With -ac /sbin/halt then stops on each disk 
for couple of seconds, because of drive in sleep mode does not respond,
and so IDE driver has to timeout, reinit interface and flush cache
(fortunately drive does not spin up again).
                                        Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
