Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVBZI0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVBZI0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 03:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVBZI0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 03:26:42 -0500
Received: from lantana.tenet.res.in ([202.144.28.166]:4797 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261850AbVBZI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 03:26:40 -0500
Date: Sat, 26 Feb 2005 13:56:29 +0530 (IST)
From: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: calling call_usermodehelper from interrupt context
In-Reply-To: <20050226001428.7515d17b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0502261352340.31846@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0502261319130.31181@lantana.cs.iitm.ernet.in>
 <20050226001428.7515d17b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hai Mr.Andrew,
    Thanks for ur help.
If u find some more info regarding this please send me. I want to call 
user program (let it be hello world program ) from keyboard driver,

>You'll need to run schedule_work() and then run call_usermodehelper() 
Is it the right way to do it.





   Thanks&Regards,

   P.Manohar,
   Sat, 26 Feb 2005, Andrew Morton wrote:

> Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in> wrote:
>>
>> Is it possible to call call_usermodehelper from interrupt context.
>
> No.  You'll need to run schedule_work() and then run call_usermodehelper()
> from within the work function.
>
