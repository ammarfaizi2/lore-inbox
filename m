Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVHNWEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVHNWEf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 18:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVHNWEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 18:04:35 -0400
Received: from smtpout.mac.com ([17.250.248.72]:63221 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932321AbVHNWEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 18:04:35 -0400
In-Reply-To: <1123883633.5296.26.camel@localhost.localdomain>
References: <1123615983.18332.194.camel@localhost.localdomain> <1123618745.18332.204.camel@localhost.localdomain> <20050809204928.GH7991@shell0.pdx.osdl.net> <1123621223.9553.4.camel@localhost.localdomain> <1123621637.9553.7.camel@localhost.localdomain> <Pine.LNX.4.58.0508091419420.3258@g5.osdl.org> <1123643401.9553.32.camel@localhost.localdomain> <Pine.LNX.4.61.0508122036500.16845@yvahk01.tjqt.qr> <20050812184503.GX7762@shell0.pdx.osdl.net> <Pine.LNX.4.58.0508121456570.19908@localhost.localdomain> <9a87484905081212317ca8c04e@mail.gmail.com> <1123883633.5296.26.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5453A418-F493-4704-B8A9-20A20D429FCA@mac.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Chris Wright <chrisw@osdl.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] Fix PPC signal handling of NODEFER, should not affect	sa_mask
Date: Sun, 14 Aug 2005 18:04:29 -0400
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 12, 2005, at 17:53:53, Steven Rostedt wrote:
> Two more systems that are different from Linux.
>
> So far, Linux is the odd ball out.

Make that three more systems (Mac OS X has the same behavior as the  
BSDs):

zeus:~ kyle$ uname -a
Darwin zeus.moffetthome.net 8.2.0 Darwin Kernel Version 8.2.0: Fri  
Jun 24 17:46:54 PDT 2005; root:xnu-792.2.4.obj~3/RELEASE_PPC Power  
Macintosh powerpc
zeus:~ kyle$ ./test_signal
sa_mask blocks other signals
SA_NODEFER does not block other signals
SA_NODEFER does not affect sa_mask
SA_NODEFER and sa_mask blocks sig
!SA_NODEFER blocks sig
SA_NODEFER does not block sig
sa_mask blocks sig

Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.



