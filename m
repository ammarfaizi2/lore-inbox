Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267970AbUHKLKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267970AbUHKLKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 07:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUHKLKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 07:10:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26552 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267970AbUHKLKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 07:10:37 -0400
Date: Wed, 11 Aug 2004 12:54:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@redhat.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][trivial] line up 'ESR value before/after enabling vector' messages
Message-ID: <20040811105448.GA17743@elte.hu>
References: <Pine.LNX.4.61.0408110145030.2690@dragon.hygekrogen.localhost> <20040811062314.GA32700@elte.hu> <20040811104735.GA24149@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811104735.GA24149@redhat.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Jones <davej@redhat.com> wrote:

> Has this printk actually been useful ? ever ? I notice a majority of
> the time, it never changes too. If it is useful, how about changing it
> so it prints something if the value changed ?  (Something like patch
> below maybe?) Or is possible for the APIC to lock up between the two
> printk's ?

it was used to debug secondary-CPU startup problems many years ago. It
is also useful to see whether it's a real APIC we got there. I'd suggest
to remove the message altogether.

	Ingo
