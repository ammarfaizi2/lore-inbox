Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUIOOGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUIOOGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUIOOFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:05:55 -0400
Received: from mail.bifgv.com.br ([200.243.172.130]:2191 "EHLO
	mail.bifgv.com.br") by vger.kernel.org with ESMTP id S266155AbUIOODl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:03:41 -0400
Message-ID: <00b101c49b2d$12bf7f70$0700a8c0@ti10>
From: "Rodrigo FGV" <rodrigof@bifgv.com.br>
To: <linux-kernel@vger.kernel.org>
References: <2EHyq-5or-39@gated-at.bofh.it> <m34qlzbqy6.fsf@averell.firstfloor.org>
Subject: Re: [patch] tune vmalloc size
Date: Wed, 15 Sep 2004 11:05:36 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-bifgv.com.br-MailScanner-Information: Please contact the ISP for more information
X-bifgv.com.br-MailScanner: Found to be clean
X-MailScanner-From: rodrigof@bifgv.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How i know the best value to set vmalloc, it's full size of ram????
----- Original Message ----- 
From: "Andi Kleen" <ak@muc.de>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>; <kkeil@suse.de>
Sent: Wednesday, September 15, 2004 10:29 AM
Subject: Re: [patch] tune vmalloc size


> Ingo Molnar <mingo@elte.hu> writes:
>
> > there are a few devices that use lots of ioremap space. vmalloc space is
> > a showstopper problem for them.
> >
> > this patch adds the vmalloc=<size> boot parameter to override
> > __VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
> > doubles the size.
>
> Ah, Karsten Keil did a similar patch some months ago. There is
> clearly a need.
>
> But I think this should be self tuning instead. For a machine with
> less than 900MB of memory the vmalloc area can be automagically increased,
> growing into otherwise unused address space.
>
> This way many users wouldn't need to specify weird options.  So far
> most machines still don't have more than 512MB.
>
> -Andi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

