Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284730AbRLEVQ1>; Wed, 5 Dec 2001 16:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284741AbRLEVQQ>; Wed, 5 Dec 2001 16:16:16 -0500
Received: from smtp-rt-7.wanadoo.fr ([193.252.19.161]:384 "EHLO
	embelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S284737AbRLEVQE>; Wed, 5 Dec 2001 16:16:04 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
        <torvalds@transmeta.com>, <marcelo@conectiva.com.br>,
        <linux-ia64@linuxia64.org>
Subject: Re: alpha bug in signal handling
Date: Wed, 5 Dec 2001 22:15:50 +0100
Message-Id: <20011205211550.28098@smtp.wanadoo.fr>
In-Reply-To: <15374.35262.151232.521493@argo.ozlabs.ibm.com>
In-Reply-To: <15374.35262.151232.521493@argo.ozlabs.ibm.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I think David (Mosberger, not Miller :) is right here, and in fact
>this is also wrong on PPC at the moment.  However, the worst case is
>that the reschedule or signal delivery will get delayed until the next
>interrupt on that cpu (max 1/HZ seconds).  Since it is a pretty narrow
>window for the race I think it would be hard to observe the effect of
>the bug.

Yup, I found that some time ago. I though I even fixed it while hacking
on the return from exception path. The fix has probably been lost along
with some of that experimental stuff I was doing at that time though,
I remember you saying the problem wasn't that big.

Ben.


