Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbTIQPSD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 11:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbTIQPSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 11:18:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:52679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262774AbTIQPR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 11:17:59 -0400
Date: Wed, 17 Sep 2003 08:11:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Kim, Hyunchul" <kimhc@inzen.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: When does a general protection fault occur?
Message-Id: <20030917081106.6fd35ade.rddunlap@osdl.org>
In-Reply-To: <001801c37ce8$85712eb0$0122030a@kimhc>
References: <001801c37ce8$85712eb0$0122030a@kimhc>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003 15:54:20 +0900 "Kim, Hyunchul" <kimhc@inzen.com> wrote:

| 
| Hi all,
|  
| I'm studying non-executable stack patch.
| It modified do_general_protection(), the general protection fault
| handler(?).
| I wanna know when the handler is called, or where could I find it.

See Intel or AMD developer manuals for GP faults/exceptions.

You can use something like this to find do_general_protection:

$ find . -name \*\.[hcS] | xargs grep -n do_general_protection

and learn that it is in (this is from 2.6.0-test4):

./arch/i386/kernel/traps.c:420:asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
and
./arch/x86_64/kernel/traps.c:456:asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)

--
~Randy
