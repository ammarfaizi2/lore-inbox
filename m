Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVGTOTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVGTOTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVGTOTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:19:13 -0400
Received: from apisx02.abbasiapacific.com.sg ([210.24.147.18]:5904 "EHLO
	apisx02.abbasiapacific.com.sg") by vger.kernel.org with ESMTP
	id S261233AbVGTOTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:19:12 -0400
Sensitivity: 
Subject: Re: Sandisk Compact Flash
To: dhinds@sonic.net
Cc: somshekar.c.kadam@in.abb.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF56551899.13BEFC21-ON65257044.00280854-65257044.00282849@abbasiapacific.com.sg>
From: somshekar.c.kadam@in.abb.com
Date: Wed, 20 Jul 2005 12:48:59 +0530
X-MIMETrack: Serialize by Router on ABB_APEXTERNAL_WWW01/APEXTERNAL(Release 5.0.12  |February
 13, 2003) at 07/20/2005 10:19:29 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=EABBFAD7DFBB8EC48f9e8a93df938690918cEABBFAD7DFBB8EC4"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=EABBFAD7DFBB8EC48f9e8a93df938690918cEABBFAD7DFBB8EC4
Content-type: text/plain; charset=us-ascii



Hi David ,

    On my controller CF INPACK pin is connected to 3.3v.  so Comapct flash
with DMA capabilty will not be supported , i understood this .
but i did not undesrtand why only PIO mode 1 is supported is it , why not
PIO mode 4 , is it a limitation of pcmcia driver , correct me if i am wrong

Thanks In Advance
Somshekar



                                                                                                     
 (Embedded     David Hinds <dhinds@sonic.net>                                                        
 image moved   07/15/2005 10:51 AM                                                                   
 to file:                                                                                            
 pic05705.pcx)                                                                                       
                                                                                                     
                                                                                                     



To:    somshekar.c.kadam@in.abb.com
cc:    linux-kernel@vger.kernel.org
Subject:    Re: Sandisk Compact Flash

Security Level:?              Internal

On Wed, Jul 13, 2005 at 07:04:38PM +0530, somshekar.c.kadam@in.abb.com
wrote:
>
> I ma newbie to compactflash driver , I am using mpc862 PPC processor
> on my custom board having 64mb ram running linuxppc-2.4.18 kernel .
> i am using Sandisk Extreme CF 1GB which is 133x high speed, but
> found the performance with other kingston 1GB CF with slower speed ,
> is both same , CF is implemented on pcmcia port , i am not sure what
> is the mode set for transfer , Feature set command is used in which
> it sets the PIO mode or Multiword DMA transfer mode by specifying
> its value in Sector count register , i am not able to understand in
> linux kernel ide driver where this is set , is it by default set ,
> this mode is set or we need to set it , i think we should assign
> this value , right now i am not able to trace this in my code.  ,

All Compact Flash cards, in 16-bit PCMCIA card readers, operate in PIO
mode 1 (polled IO, no DMA), which means you will get only about 1
MB/sec regardless of the card's claimed tranfer speed.  Some cameras
also only support this mode; others will run CF cars in "TrueIDE"
mode, which is required to use the DMA transfer modes.

There are high performance CF card readers that can use TrueIDE mode:
both CardBus ones and Firewire ones.  For example:

http://www.dpreview.com/news/0310/03102103delkincardbustest.asp

It sounds like your card reader is one of the slow 16-bit ones.

-- Dave





--0__=EABBFAD7DFBB8EC48f9e8a93df938690918cEABBFAD7DFBB8EC4
Content-type: application/octet-stream; 
	name="pic05705.pcx"
Content-Disposition: attachment; filename="pic05705.pcx"
Content-transfer-encoding: base64

CgUBCAAAAABBADEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAABQgABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAA=

--0__=EABBFAD7DFBB8EC48f9e8a93df938690918cEABBFAD7DFBB8EC4--

