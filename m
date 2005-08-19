Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVHSNlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVHSNlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVHSNlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:41:45 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:30903 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S932486AbVHSNlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:41:44 -0400
Message-ID: <4305E189.1080903@ens-lyon.org>
Date: Fri, 19 Aug 2005 15:41:29 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
References: <20050819043331.7bc1f9a9.akpm@osdl.org> <4305DDBF.1060309@ens-lyon.org> <20050819142746.B2880@flint.arm.linux.org.uk>
In-Reply-To: <20050819142746.B2880@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19.08.2005 15:27, Russell King a écrit :
> Since you're going to be adding #ifdef CONFIG_SMP...#endif around each
> of these, why not fix where it's declared/defined to be empty?

Probably because I'm too lazy to find a nice way to fix it :)

smp_nmi_call_function may return an error but I don't see any place
where the return value is actually checked. If the error case is
actually possible, we should check the return value, and the warning
would disappear.

Sorry but I'm not familiar enough with this code to know what's the
good solution :(

Regards,
Brice
