Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbUK2WsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbUK2WsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUK2Wru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:47:50 -0500
Received: from mail.dnm.gov.ar ([200.55.54.66]:2720 "EHLO mail.dnm.gov.ar")
	by vger.kernel.org with ESMTP id S261854AbUK2WpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:45:24 -0500
Message-ID: <41ABA712.6050407@migraciones.gov.ar>
Date: Mon, 29 Nov 2004 19:47:46 -0300
From: Javier Villavicencio <javierv@migraciones.gov.ar>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: no entropy and no output at /dev/random  (quick question)
References: <41A7EDA1.5000609@migraciones.gov.ar> <Pine.LNX.4.53.0411272019350.27610@yvahk01.tjqt.qr> <41A8D89B.9090909@domdv.de>
In-Reply-To: <41A8D89B.9090909@domdv.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:
> Jan Engelhardt wrote:
> 
>> I doubt that timer and eth* are a non-predictable source. As such, 
>> they should
>> not contribute to the entropy. Better is the keyboard and/or mouse. 
>> SSH traffic
>> is network traffic, and if you send it to a network card, you can 
>> expect an
>> interrupt at <time>... prdictable.
> 
> 
> Timer, ok. But network - only if you are in full control of the network 
> segment the system is attached to which may be the case for your private 
> network but usually you can't predict what network traffic is actually 
> going on.
I'm in control of "one" of the network segments, the other is connected 
to the internet which is a bad source of entropy I know, so I've enabled 
the SA_SAMPLE_RANDOM in the request_irq() call just for my local lan 
nic, but the "other" source of good entropy should be the DAC(RAID) 
controller, right?, I was just curious about why this driver didn't had 
this flag enabled in its request_irq call.

-- 

       Javier Villavicencio
      Administrador/Consultor
Direccion Nacional de Migraciones
      Ministerio del Interior
       Republica Argentina
