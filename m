Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSHEJXR>; Mon, 5 Aug 2002 05:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSHEJXQ>; Mon, 5 Aug 2002 05:23:16 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:12284 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318348AbSHEJXQ>; Mon, 5 Aug 2002 05:23:16 -0400
Subject: Re: Thread group exit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Zeuner, Axel" <Axel.Zeuner@partner.commerzbank.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A1081E14241CD4119D2B00508BCF80410843F27D@SV021558>
References: <A1081E14241CD4119D2B00508BCF80410843F27D@SV021558>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 11:45:28 +0100
Message-Id: <1028544328.17780.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 09:58, Zeuner, Axel wrote:
> I would expect, that changes of the parent of one member of the thread group
> do not affect the interactions between the members of the group. 
> Corrections are welcome.
> (Please cc mails to me, I read only the archives of the 
> linux-kernel list.)

I agree with your diagnosis I'm not convinced by your change. The thread
groups are only used by NGPT not by glibc pthreads while the problem is
true across both.

Possibly the right fix is to remove the reparent to init increment of
self_exec_id and instead explicitly check process 1 in the signal paths.

Opinions ?

