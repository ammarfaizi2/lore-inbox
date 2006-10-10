Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWJJGon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWJJGon (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWJJGon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:44:43 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:15925 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S965023AbWJJGom convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:44:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
Date: Mon, 9 Oct 2006 23:44:35 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B018E81719@hqemmail02.nvidia.com>
In-Reply-To: <4527CDCC.1080209@shaw.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
Thread-Index: AcbqKSAn2IPwppfeQqGEvj/OP0AsTACDdweA
From: "Allen Martin" <AMartin@nvidia.com>
To: "Robert Hancock" <hancockr@shaw.ca>,
       "Prakash Punnoor" <prakash@punnoor.de>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
       <jeff@garzik.org>
X-OriginalArrivalTime: 10 Oct 2006 06:44:24.0840 (UTC) FILETIME=[865F8080:01C6EC37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Unfortunately it doesn't work for me on MCP51 if I change 
> GENERIC to 
> > ADMA. So I wonder whether MCP51 has ADMA mode or what needs 
> to be done 
> > to get NCQ working. :-(
> 
> What happened when you tried it? It would be useful if you 
> could change the #undef in these lines:
> 
>   53 #undef ATA_DEBUG                /* debugging output */
>   54 #undef ATA_VERBOSE_DEBUG        /* yet more debugging output */
> 
> in include/linux/libata.h to #define and rebuild and try it 
> then, that will spew out a bunch more output and I can see if 
> any reasonable looking values are showing up at all. I was 
> capturing this output the crude way, booting with vga=6 to 
> get a smaller font and taking a picture of the screen :-) 
> Also, maybe post the lspci -v output from the SATA controller..
> 
> If that doesn't provide any insight, maybe the docs Jeff has 
> provide the answer for whether or not the MCP5x/MCP61 
> controllers have the same interface as the CK804/MCP04..

No, only CK804 and MCP04 support ADMA.  We'll be publishing some patches
for NCQ support for MCP55/MCP61 soon.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
