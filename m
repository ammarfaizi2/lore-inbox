Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUJJQd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUJJQd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 12:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268339AbUJJQd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 12:33:58 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:29606 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S268329AbUJJQdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 12:33:55 -0400
Message-ID: <41696514.90303@conectiva.com.br>
Date: Sun, 10 Oct 2004 13:36:36 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] __initdata strings
References: <2NNXM-1fZ-5@gated-at.bofh.it> <m38yae1ss7.fsf@averell.firstfloor.org> <41695F85.A0000E3D@tv-sign.ru>
In-Reply-To: <41695F85.A0000E3D@tv-sign.ru>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oleg Nesterov wrote:
> Andi Kleen wrote:
> 
>>There is a more generic way to do this with gcc extensions. Something like

Or with a pre-processor, using a sparse based tool such as this one I've
written a long time ago:

http://www.kernel.org/pub/linux/kernel/people/acme/sparse/initstr.c

That uses what Andi described, but does this automatically if initstr is
made part of the building process.

>>
>>#define __i(x) ({ static char __str[] __initdata = x; __str; })

Regards,

- Arnaldo
