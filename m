Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131942AbRDFQYQ>; Fri, 6 Apr 2001 12:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131976AbRDFQX4>; Fri, 6 Apr 2001 12:23:56 -0400
Received: from jalon.able.es ([212.97.163.2]:28557 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131942AbRDFQXq>;
	Fri, 6 Apr 2001 12:23:46 -0400
Date: Fri, 6 Apr 2001 18:22:57 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Christopher Turcksin <turcksin@raleigh.ibm.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
        "Miller, Brendan" <Brendan.Miller@Dialogic.com>,
        "'linux-kernel @ vger . kernel . org'" <linux-kernel@vger.kernel.org>
Subject: Re: Proper way to release binary driver?
Message-ID: <20010406182257.A2980@werewolf.able.es>
In-Reply-To: <EFC879D09684D211B9C20060972035B1D46A39@exchange2ca.sv.dialogic.com> <m1g0fnwoo0.fsf@frodo.biederman.org> <3ACDE5C5.CEB65D4A@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3ACDE5C5.CEB65D4A@raleigh.ibm.com>; from turcksin@raleigh.ibm.com on Fri, Apr 06, 2001 at 17:50:29 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.06 Christopher Turcksin wrote:
> 
> In practice, that doesn't work. A driver compiled with 2.2.16 doesn't
> load with 2.2.16-5.0 (from RedHat 6.2) (just an example). 
> 

Thats is probably because RH 2.2.16-5.0 is not 2.2.16, but 2.2.17-pre-something.
Due to the bad idea of distros to name kernels in its own way, you can
never know which kernel are they giving if you do not read the changelog
from rpm.

For example, in Mandrake you get:

werewolf:~/in# rpm -q --changelog kernel-smp | more
* Thu Apr 05 2001 Chmouel Boudjnah <chmouel@mandrakesoft.com> 2.4.3-8mdk

- btt upgrade to 0.7.62.

* Thu Apr 05 2001 Chmouel Boudjnah <chmouel@mandrakesoft.com> 2.4.3-7mdk

- 2.4.3-ac3.
- Fix wait on psaux port (prumph).

So my naming scheme would be:
2.4.3-7mdk -> 2.4.3-ac3-1mdk
2.4.3-8mdk -> 2.4.3-ac3-2mdk.

An <ac> or <pre> release can have changed some important things from its
stable parent, and should be evident which version is a kernel from its
rpm name...

I do not think that the other patches distros apply change important things,
but correct bugs. So really you should only track the -preX and -acX releases
from Linus and Alan.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac3 #1 SMP Thu Apr 5 00:28:45 CEST 2001 i686

