Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVEXJaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVEXJaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVEXJ2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:28:24 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:14786 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261986AbVEXJRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:17:51 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091750.75FDFFA3F@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:17:50 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id BE232FB71

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:45 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261355AbVEXGwi (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:52:38 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVEXGwi

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:52:38 -0400

Received: from mx2.elte.hu ([157.181.151.9]:24245 "EHLO mx2.elte.hu")

	by vger.kernel.org with ESMTP id S261355AbVEXGwe (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:52:34 -0400

Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])

	by mx2.elte.hu (Postfix) with ESMTP id D26D231CA62;

	Tue, 24 May 2005 08:43:21 +0200 (CEST)

Received: by chiara.elte.hu (Postfix, from userid 17806)

	id 63EF71FC2; Tue, 24 May 2005 08:45:33 +0200 (CEST)

Date:	Tue, 24 May 2005 08:45:22 +0200

From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
	Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance

Message-ID: <20050524064522.GA9385@elte.hu>

References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org>

Mime-Version: 1.0

Content-Type: text/plain; charset=us-ascii

Content-Disposition: inline

In-Reply-To: <20050524054722.GA6160@infradead.org>

User-Agent: Mutt/1.4.2.1i

X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73

X-ELTE-VirusStatus: clean

X-ELTE-SpamCheck: no

X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,

	BAYES_00 -4.90

X-ELTE-SpamLevel: 

X-ELTE-SpamScore: -4

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org




* Christoph Hellwig <hch@infradead.org> wrote:

> Personally I think interrupt threads, spinlocks as sleeping mutexes 
> and PI is something we should keep out of the kernel tree. [...]

it's not really a problem - they integrate nicely. They also found 
dozens of hard-to-catch bugs already so if you dont care about embedded 
systems at all then worst-case you can consider it a spinlock debugging 
mechanism, with the difference that DEBUG_SPINLOCK is far uglier ;) 
Anyway, this discussion is premature, as i'm not submitting all these 
patches yet.

	Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

