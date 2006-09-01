Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWIACbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWIACbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 22:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWIACbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 22:31:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:11304 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750778AbWIACbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 22:31:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SBT6ClMXA+zN0bOBk0+ny/B2dONSuf5pZXvegZbOwL1eVR+MHRH9fuvTwx3EGpQ6LA+IOZpdlUqd4gAA2RUHzSkjveoW+poBUJqjMaIX8xziMmux32j0ty+qv7eFkBiC56MKscYJYyx1WPwyVuAlMmkN9l+fF0x/2hHJmQ553V0=
Message-ID: <b115cb5f0608311931j3444db63h1770c5b7c818ee94@mail.gmail.com>
Date: Fri, 1 Sep 2006 08:01:16 +0530
From: "Rajat Jain" <rajat.noida.india@gmail.com>
To: "Manoj Awasthi" <lkml.manoj@gmail.com>
Subject: Re: Spinlock query
Cc: "Rik van Riel" <riel@surriel.com>, "Rick Brown" <rick.brown.3@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <fa2bedd60608292159ra9fce70wd1dbc8231d9c052c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7783925d0608291912i3f04d460kc9edebf9d358dbc3@mail.gmail.com>
	 <44F501B3.9070200@surriel.com>
	 <fa2bedd60608292159ra9fce70wd1dbc8231d9c052c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > You need to use spin_lock_irqsave() from process context.
> > From the interrupt handler itself it doesn't hurt, but it
> > shouldn't matter much since interrupt handlers should not
> > get preempted.
>
>
> but interrupt handlers run in interrupt context when interrupts are already
> disabled. Is that correct ?
>

AFAIK the interrupt that the handler is serving is guaranteed to be
disabled on all the processors.

In addition, if the interrupt was registered with SA_INTERRUPT flag,
all the interrupts will be disabled on the current processor.

Regards,

Rajat
