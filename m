Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVFKRVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVFKRVR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVFKRVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:21:16 -0400
Received: from mail-gw.turkuamk.fi ([195.148.208.32]:48270 "EHLO
	mail-gw.turkuamk.fi") by vger.kernel.org with ESMTP id S261753AbVFKRUt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:20:49 -0400
Message-ID: <42AB1DD5.8010009@kolumbus.fi>
Date: Sat, 11 Jun 2005 20:22:29 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
References: <Pine.LNX.4.10.10506111011470.27294-100000@godzilla.mvista.com>
In-Reply-To: <Pine.LNX.4.10.10506111011470.27294-100000@godzilla.mvista.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.13a
  |April 8, 2004) at 11.06.2005 20:20:41,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4|March
 27, 2005) at 11.06.2005 20:20:42,
	Serialize complete at 11.06.2005 20:20:42
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:

>On Sat, 11 Jun 2005, [UTF-8] Mika Penttilä wrote:
>  
>
>>The timer irq is run as NODELAY, so soft irqs are run against 
>>local_irq_disable sections all the time.
>>    
>>
>
>Softirq's are run in threads . The wake_up_process() path is protected,
>and used by the timer interrupt .
>
>
>Daniel
>
>
>  
>
Not with !softirq_preemption, then we take the immediate path and 
process soft irqs on irq exit.

--Mika


