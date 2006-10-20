Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992708AbWJTX1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992708AbWJTX1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 19:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWJTX1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 19:27:17 -0400
Received: from web55603.mail.re4.yahoo.com ([206.190.58.227]:60251 "HELO
	web55603.mail.re4.yahoo.com") by vger.kernel.org with SMTP
	id S1750931AbWJTX1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 19:27:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6i6W6ZxpHPikyc8NyKXxNQvVqVR2D8EdTSRjCS8Z1zXgBN1ruDfyu/MDInRBKGSd0fcsuyUNn6se8ip8O1kmr1mN/84PWdgW+6J588/z3hWYqkqs6ygI2AQA/m1cMbqiEQvhW5hNSvp20QGmvLl2CUtSNQaKcb5KPBsbnQC7MoQ=  ;
Message-ID: <20061020232711.54568.qmail@web55603.mail.re4.yahoo.com>
Date: Fri, 20 Oct 2006 16:27:10 -0700 (PDT)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH 2.6.19-rc2] [REVISED 2] drivers/media/video/se401.c: check kmalloc() return value.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1161350098.26440.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> If you know se401->sbuf[] and se401->scratch , urb etc are being cleared
> to NULL (or you did that) you could just use the kfree loops in nomem_
> for all cases as kfree(NULL) is an allowed "no-op"
> 
> 

In se401_stop_stream(), se401->sbuf[i].data is kfreed but not set to NULL. So, I could have
changed it there. But then I decided not to depend on anything else and do everything in
se401_start_stream(). But if this approach is wrong then please let me know.

Regards,
Amit

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
