Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbVHXTx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbVHXTx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbVHXTx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:53:59 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:12937 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751501AbVHXTx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:53:58 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: question on memory barrier
Date: Wed, 24 Aug 2005 12:53:53 -0700
User-Agent: KMail/1.8.2
Cc: moreau francis <francis_moreau2000@yahoo.fr>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0508240854550.28064@chaos.analogic.com> <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com> <20050824194836.GA26526@hexapodia.org>
In-Reply-To: <20050824194836.GA26526@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508241253.53586.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 24, 2005 12:48 pm, Andy Isaacson wrote:
> The first register write will be completed before the second register
> write because you use writel, which is defined to have the semantics
> you want.  (It uses a platform-specific method to guarantee this,
> possibly "volatile" or "asm("eieio")" or whatever method your platform
> requires.)

writel() ensures ordering?  Only from one CPU, another CPU issuing a 
write at some later time may have its write arrive first.  See 
Documentation/io_ordering.txt for some documentation I put together on 
this issue.

Jesse
