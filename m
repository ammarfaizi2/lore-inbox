Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAETcX>; Fri, 5 Jan 2001 14:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRAETcO>; Fri, 5 Jan 2001 14:32:14 -0500
Received: from barnowl.demon.co.uk ([158.152.23.247]:43780 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129183AbRAETcI>; Fri, 5 Jan 2001 14:32:08 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: kernel network problem ?
In-Reply-To: <000d01c07724$8fa531f0$8900030a@nicolasp>
	<m3elyiroo9.fsf@shookay.e-steel.com>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 05 Jan 2001 19:31:24 +0000
In-Reply-To: <m3elyiroo9.fsf@shookay.e-steel.com>
Message-ID: <m2itntu777.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Chouquet-Stringer <mchouque@e-steel.com> writes:

> Note that, on the Internet, there are many broken firewalls which
> refuse connections from ECN-enabled machines, and it may be a while
> before these firewalls are fixed. Until then, to access a site behind
> such a firewall (some of which are major sites, at the time of this
> writing) you will have to disable this option, either by saying N now
> or by using the sysctl.

As well as this, it might be worthwhile to complain to these
sites. Otherwise if everyone just turns off ECN then those sites which
block it will probably not fix their problem and ECN will not gain
"public" acceptance. It would be great pity if this were to happen as
ECN has the potential (if widely supported) to greatly reduce network
congestion and bandwidth "waste".

Would it perhaps be possible to have ECN enabled but use something
such as IPTables to unset it when connecting to those sites which
reject ECN connections? So that you could define a rule something like

iptables -A OUTPUT -p tcp --syn -d 1.2.3.4 -j unsetecn
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
