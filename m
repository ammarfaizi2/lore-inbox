Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUK3Qte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUK3Qte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUK3QsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:48:22 -0500
Received: from mail.dnm.gov.ar ([200.55.54.66]:14248 "EHLO mail.dnm.gov.ar")
	by vger.kernel.org with ESMTP id S262170AbUK3QqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:46:12 -0500
Message-ID: <41ACA45B.206@migraciones.gov.ar>
Date: Tue, 30 Nov 2004 13:48:27 -0300
From: Javier Villavicencio <javierv@migraciones.gov.ar>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: no entropy and no output at /dev/random (quick question)
References: <200411301249.iAUCnJgs004281@laptop11.inf.utfsm.cl>
In-Reply-To: <200411301249.iAUCnJgs004281@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

> daw@taverner.cs.berkeley.edu (David Wagner) said:
> 
>>Javier Villavicencio  wrote:
>>
>>>it's encouraged to use /dev/urandom instead of /dev/random?
> 
> 
>>Yes, for almost all purposes, applications should use /dev/urandom,
>>not /dev/random.  (The names for these devices are unfortunate.)
> 
> 
> To seed a random number generator, never directly.
> 
> 
>>Sadly, many applications fail to follow these rules, and consequently
>>/dev/random's entropy pool often ends up getting depleted much faster
>>than it has to be.
> 
> 
> Reading /dev/urandom depletes exactly the same pool, it just doesn't block
> when the pool is empty. As said pool has other uses, indiscriminate reading
> of either can DoS other parts of the system.

But why if /dev/random depletes and you don't have any source of entropy 
? As you may have seen in my setup I had no mouse/keyboard attached to 
that server, and the only "things" capable of generate entropy where the 
two nics and the DAC960.
So I've enabled entropy only for the local nic and the DAC960 (at least 
"I think", for the dac :+) and now I'm plenty of entropy, but for a 
setup like this, the server may have been running without entropy at all 
for weeks (I've forgot to check the uptime :+P).
About this, think about php generating session_id()s without entropy 
(o_O), and stuff like that....

Salu2.

Javier Villavicencio.

