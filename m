Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318663AbSHAIqb>; Thu, 1 Aug 2002 04:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318666AbSHAIqb>; Thu, 1 Aug 2002 04:46:31 -0400
Received: from [217.167.51.129] ([217.167.51.129]:496 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S318663AbSHAIqa>;
	Thu, 1 Aug 2002 04:46:30 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Lincoln Dale <ltd@cisco.com>
Cc: David Luyer <david_luyer@pacific.net.au>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Date: Thu, 1 Aug 2002 10:49:19 +0200
Message-Id: <20020801084920.15476@192.168.4.1>
In-Reply-To: <200208010133.g711Xq7338295@saturn.cs.uml.edu>
References: <200208010133.g711Xq7338295@saturn.cs.uml.edu>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>2.2.xx i386 as shipped by Linus
>2.4.xx i386 with HZ modified
>
>Come on, write the code if you think it's so easy.
>You get bonus points for supporting 2.0.xx kernels
>and the IA-64 kernel with that same executable.
>
>Maybe you think I should tell these people to go to Hell?
>In that case, what about the Alpha systems that ran HZ at
>1200 instead of 1024?

Isn't HZ value passed down to userland via the ELF aux table ?

(At least the "userland visible" one, which isn't the kernel
internal one in recent 2.5's, oh well...)

That's a reason I don't understand why Linus did this separation
between "userland visibl" HZ and kernel internal HZ. I would have
just changed the kernel HZ and let userland be fixed to use the
value passed via the aux table instead of hard coding it.

Ben.


