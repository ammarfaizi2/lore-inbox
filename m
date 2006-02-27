Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWB0Sup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWB0Sup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWB0Sup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:50:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:13546 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751599AbWB0Sun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:50:43 -0500
X-Authenticated: #31060655
Message-ID: <440349F6.5020606@gmx.net>
Date: Mon, 27 Feb 2006 19:50:30 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: pomac@vapor.com
CC: Arjan van de Ven <arjan@infradead.org>, woho@woho.de,
       Stephen Hemminger <shemminger@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert sky2 to 0.13a
References: <4400FC28.1060705@gmx.net>	 <20060225180353.5908c955@localhost.localdomain>	 <200602260957.04305.woho@woho.de>  <1140966011.22812.2.camel@localhost>	 <1140968831.2934.32.camel@laptopd505.fenrus.org>	 <1140970427.23375.11.camel@localhost>  <44022DEC.1070601@gmx.net> <1141001028.23375.14.camel@localhost>
In-Reply-To: <1141001028.23375.14.camel@localhost>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien schrieb:
> On Sun, 2006-02-26 at 23:38 +0100, Carl-Daniel Hailfinger wrote:
> 
>>Ian Kumlien schrieb:
>>
>>>I also saw some oddities... portage stopped working, i dunno if this can
>>>be MSI related or so, else something is trashing memory in a very
>>>special way =P
>>
>>Yes, 0.15 causes memory corruption even if MSI is disabled.
> 
> 
> So if i run with iommu=forced or what the hell the option is called i
> should be able to catch these trashings?
> 
> I also found it odd that it was only python that suffered... Starting
> large and long running C apps worked just fine.

For me, it was usually timer list corruption during boot (50% probability)
or unidentified lockups (probably also timer list corruption) after a few
minutes of operation (40% probability).
Sample Oops message:

Unable to handle kernel NULL pointer dereference at 00000008
rip: run_timer_softirq+322
process udev
Call trace:
__do_softirq+68
call_softirq+30
do_softirq+46
do_IRQ+61
ret_from_intr+0
EOI


Regards,
Carl-Daniel
