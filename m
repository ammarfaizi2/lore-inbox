Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268201AbTGIMaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 08:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268222AbTGIMaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 08:30:08 -0400
Received: from ns.suse.de ([213.95.15.193]:26374 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268201AbTGIMaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 08:30:06 -0400
To: "Kirill Korotaev" <kksx@mail.ru>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
References: <E19aCeB-000ICs-00.kksx-mail-ru@f23.mail.ru.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Jul 2003 14:44:40 +0200
In-Reply-To: <E19aCeB-000ICs-00.kksx-mail-ru@f23.mail.ru.suse.lists.linux.kernel>
Message-ID: <p73wuerq37r.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kirill Korotaev"  <kksx@mail.ru> writes:

> I didn't change TASK_SIZE in my patch, since there is a bug in libpthread,
> which causes SIGSEGV when java on non-standart kernel split is run :(((
> Test it with your kernel pls if not yet. You can find a jbb2000 test in
> internet.

That's fixed in the Sun JVM 1.4.2, or in Blackdown 1.4.1. I had the same
problem on AMD64. Currently it has a special "3GB" personality to 
deal with the older JVMs. All the personality does is to move the top
of stack, an application could still place mmaps behind it.

-Andi
