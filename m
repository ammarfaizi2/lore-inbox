Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271680AbTGRCPd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271681AbTGRCPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:15:33 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:2565 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S271680AbTGRCPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:15:32 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	<3F16C190.3080205@pobox.com>
	<200307171756.19826.schlicht@uni-mannheim.de>
	<3F16C83A.2010303@pobox.com>
	<20030717125942.7fab1141.davem@redhat.com>
	<1058477803.754.11.camel@ezquiel.nara.homeip.net>
	<20030717144031.3bbacee5.davem@redhat.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030717144031.3bbacee5.davem@redhat.com>
Date: 17 Jul 2003 22:27:57 -0400
Message-ID: <m3isq0d0wi.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

>> Can't shutdown the system either. Init hangs waiting for
>> modprobe to die.

As this happened to me too, when I wanted to try out the new e100
module w/o rebooting, I'll pipe in below.

David> That's a bug we need to fix.

David> What driver are you using? 

e100.ko

David> Are you using ipv6? 

Yes, compiled in.

David> Any netfilter modules?

Yes, a basic firewall + nat, with eth0 as the inside and ppp0 outside.
It is a mix of compiled in and modular.

David> Anything else interesting or "unique" about your
David> particular setup?

It used to be rmmod would fail until all of the sockets were closed.
Instead it just hung.  Attempting to shutdown network services to
free any eth0 sockets didn't help.  A reboot attempt also hung as
per above.  Had to use SysRq to sync/umount/boot.

The exact .config is available in bk://cloos.bkbits.net/linux-2.5-jhc
as of the revision dated 2003/06/28.  That was between 2.5.73 and .74.

-JimC

