Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVIUMSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVIUMSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 08:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVIUMSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 08:18:00 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:33453 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750848AbVIUMR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 08:17:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uOeT96jolzbOHwaoko50O+Gf7T3gILSVcOnmply/WqSc1p1DtVCzrzLEIxQtQx8pXs3Ai1GMoHZbjAUQTXJ129EjlLP7qG8nnc2l4h777GH0dhZ7Z+bAU9fGWyl/obt59nCyIkMWFUrh2jHyZoerCwoKvzEJDx4tQ86PL8xn82E=  ;
Message-ID: <43314F92.5040801@yahoo.com.au>
Date: Wed, 21 Sep 2005 22:18:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       joe-lkml@rameria.de, George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] NTP shift_right cleanup (v. A3)
References: <1127273050.11080.34.camel@cog.beaverton.ibm.com> <43313241.19315.AC261D7@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-Reply-To: <43313241.19315.AC261D7@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:

> 
> Hi,
> 
> I'm against "signed shift right", because the reason for the macro is exaclty that 
> CPUs do a "signed" shift right. John does a "signum(arg) * right_shift(abs(arg), 
> number_of_positions)". So maybe it's the signed_unsigned_shift_right(), susr() to 
> be cryptic ;-)
> 

I see, so that would be a divide by 2^shift?

Well, nevermind - I guess the patch is better than what was
there before.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
