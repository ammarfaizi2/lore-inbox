Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbTBUBcd>; Thu, 20 Feb 2003 20:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTBUBcd>; Thu, 20 Feb 2003 20:32:33 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:14355 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267032AbTBUBcc>; Thu, 20 Feb 2003 20:32:32 -0500
Date: Fri, 21 Feb 2003 12:42:26 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ATM] who 'owns' the skb created by drivers/atm?
In-Reply-To: <200302210118.h1L1IkKw011688@locutus.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.44.0302211241070.12797-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, chas williams wrote:

> its my understanding is that you can't use skb->cb unless you created
> the skb.  well atm created the skb and filled in ->cb.  it seems ip
> doesn't know its sharing this skb with the atm layer and doesnt clone
> the skb in ip_rcv().  there seems to be an implicit understanding that
> skb's created by ethernet drivers are 'owned' by the ip layer and shouldnt
> touch skb->cb.
> 

skb->cb is owned by whatever layer is currently processing the skb.


- James
-- 
James Morris
<jmorris@intercode.com.au>


