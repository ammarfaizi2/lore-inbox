Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbTLYMYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 07:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTLYMYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 07:24:03 -0500
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:22501 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S264299AbTLYMYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 07:24:00 -0500
Message-ID: <3FEAD582.10908@upb.de>
Date: Thu, 25 Dec 2003 13:18:10 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4.1) Gecko/20031008
X-Accept-Language: de, en
MIME-Version: 1.0
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: allow process or user to listen on priviledged ports?
References: <bscg1m$1eg$1@sea.gmane.org> <20031225104526.GA10239@axis.demon.co.uk>
In-Reply-To: <20031225104526.GA10239@axis.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.upb.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.275,
	required 4, AUTH_EIM_USER -5.00, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would give your application this capability (from #include "linux/capability.h")
> 
>   /* Allows binding to TCP/UDP sockets below 1024 */
>   /* Allows binding to ATM VCIs below 32 */
> 
>   #define CAP_NET_BIND_SERVICE 10
> 
> You do this with a setuid wrapper which drops all capabilities but
> that one and then runs your application.

Thx for the answer! That's exactly what i search for.

I will try to write such a program. It seems that sucap keeps all 
capabilities and drops none. Depending on the other capabilities, that 
could be a bad idea.

Thx
   Sven

