Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267927AbTAHUky>; Wed, 8 Jan 2003 15:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267928AbTAHUky>; Wed, 8 Jan 2003 15:40:54 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:54166 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267927AbTAHUkx>;
	Wed, 8 Jan 2003 15:40:53 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 8 Jan 2003 21:49:39 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PCI code:  why need  outb (0x01, 0xCFB); ?
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <CACAEBD1F1C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Jan 03 at 10:52, H. Peter Anvin wrote:
> 
> > 1. which device is at port address 0xCFB?
> 
> Hopefully none.

Actually I'm not sure. This code is here since at least 2.0.28,
and during googling I even found code for direct PCI access
(http://www-user.tu-chemnitz.de/~heha/viewzip.cgi/hs_freeware/gerald.zip/DIRECTNT.CPP?auto=CPP)
which sets lowest bit at 0xCFB to 1 before doing PCI config
accesses and reset it back to original value afterward.

So I believe that there were some chipsets (probably in 486&PCI times)
which did conf1/conf2 accesses depending on value of this bit.
Unfortunately I was not able to confirm this - almost nobody provides
northbridge datasheets from '94 era, even Intel does not provide them
(f.e. Neptune) anymore :-(
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
