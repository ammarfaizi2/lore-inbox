Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUHJWeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUHJWeZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267762AbUHJWeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:34:25 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:19091 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267791AbUHJWeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:34:21 -0400
Subject: Re: [RFC] Fix Device Power Management States
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
In-Reply-To: <20040810102054.GG9034@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
	 <20040809113829.GB9793@elf.ucw.cz>
	 <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
	 <20040809212949.GA1120@elf.ucw.cz>
	 <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
	 <1092130981.2676.1.camel@laptop.cunninghams>
	 <20040810102054.GG9034@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Message-Id: <1092177233.2709.8.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 11 Aug 2004 08:33:54 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-08-10 at 20:20, Pavel Machek wrote:
> I needed to do highmem anyway (for SUSE kernel)... SMP... I'm not 100%
> convinced that SMP support in suspend2 is correct. (Notice: swsusp/SMP
> support in current mainline is *not* correct, either). In particular,
> if you sleep the CPU, it needs to loop somewhere, right? Can you quote
> the piece of code where sleeping CPUs are spinning? ...that one needs
> to be in assembly :-(.

In suspend2, it's in arch/i386/power/suspend2.c, involved via code near
the start of kernel/power/process.c. The bulk of it is not in assembly,
and doesn't need to be. If you get the latest version from
softwaresuspend.berlios.de, you'll see that I've separated the secondary
processors support out and tidied it a bit. It works perfectly for me.

> Anyway, I believe that refrigerator merge can be done in paralel with
> device tree changes, as it will be always very clear what is broken.

I'll try to start producing patches asap. (Within the constraints I have
by having a real job as well :>).

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

