Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWFNO23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWFNO23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWFNO22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:28:28 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:34164 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S964978AbWFNO21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:28:27 -0400
Message-ID: <44901CC1.60403@cfl.rr.com>
Date: Wed, 14 Jun 2006 10:27:13 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Jesper Dangaard Brouer <hawk@comx.dk>
CC: Stephen Hemminger <shemminger@osdl.org>,
       Jamal Hadi Salim <hadi@cyberus.ca>, netdev@vger.kernel.org,
       lartc@mailman.ds9a.nl, russell-tcatm@stuart.id.au, hawk@diku.dk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] NET: Accurate packet scheduling for ATM/ADSL
References: <1150278004.26181.35.camel@localhost.localdomain>
In-Reply-To: <1150278004.26181.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jun 2006 14:28:31.0509 (UTC) FILETIME=[CF897C50:01C68FBE]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14506.003
X-TM-AS-Result: No--1.900000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Dangaard Brouer wrote:
> The Linux traffic's control engine inaccurately calculates
> transmission times for packets sent over ADSL links.  For
> some packet sizes the error rises to over 50%.  This occurs
> because ADSL uses ATM as its link layer transport, and ATM
> transmits packets in fixed sized 53 byte cells.
> 

I could have sworn that DSL uses its own framing protocol that is 
similar to the frame/superframe structure of HDSL ( T1 ) lines and over 
that you can run ATM or ethernet.  Or is it typically ethernet -> ATM -> 
HDSL?

In any case, why does the kernel care about the exact time that the IP 
packet has been received and reassembled on the headend?


