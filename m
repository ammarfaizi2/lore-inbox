Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263378AbRFFF5H>; Wed, 6 Jun 2001 01:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263379AbRFFF45>; Wed, 6 Jun 2001 01:56:57 -0400
Received: from [204.94.214.22] ([204.94.214.22]:23073 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S263378AbRFFF4i>; Wed, 6 Jun 2001 01:56:38 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Proper perfect filter setup for xircom_tulip_cb.c 
In-Reply-To: Your message of "Tue, 05 Jun 2001 22:34:05 MST."
             <Pine.LNX.4.33.0106052225290.22593-100000@age.cs.columbia.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Jun 2001 15:55:34 +1000
Message-ID: <29308.991806934@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001 22:34:05 -0700 (PDT), 
Ion Badulescu <ionut@cs.columbia.edu> wrote:
>The reason some CardBus Xircom cards need to be put in promisc mode in 
>order to receive packets is because the driver doesn't initialize the 
>perfect filter correctly. Although it uses a single Tx descriptor to send 
>the initialization data to the card, it doesn't set either of the 
>first_segment or last_segment bits in the descriptor. No wonder the 
>chipset gets confused...

Nicely spotted.  The X3201-3 Software Specification says nothing about
the segment bits for the filter, instead the information is tucked away
in the 21143 PCI/CardBus 10/100Mb/s Ethernet LAN Controller Hardware
Reference Manual.  So Xircom have a software specification manual that
does not include the full software spec, oh the horrors.

