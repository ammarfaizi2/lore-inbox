Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVBWEWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVBWEWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 23:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVBWEWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 23:22:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:46006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261412AbVBWEWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 23:22:45 -0500
Message-ID: <421C04FA.8090706@osdl.org>
Date: Tue, 22 Feb 2005 20:22:18 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tobias DiPasquale <codeslinger@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, John Heffner <jheffner@psc.edu>,
       mlists@danielinux.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, ccaini@deis.unibo.it,
       rfirrincieli@arces.unibo.it
Subject: Re: [PATCH] TCP-Hybla proposal
References: <200502221534.42948.mlists@danielinux.net>	 <20050222094219.0a8efbe1@dxpl.pdx.osdl.net>	 <Pine.LNX.4.58.0502221247130.22393@dexter.psc.edu>	 <20050222101447.68a02c12.davem@davemloft.net> <876ef97a050222164140968e15@mail.gmail.com>
In-Reply-To: <876ef97a050222164140968e15@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 22 Feb 2005 10:14:47 -0800, David S. Miller <davem@davemloft.net> wrote:
> 
>>> On Tue, 22 Feb 2005 13:03:11 -0500 (EST)
>>> John Heffner <jheffner@psc.edu> wrote:
>>> 
>>
>>>> > An idea I've been toying with for a while now is completely abstracting
>>>> > congestion control.  Then you could have congestion control loadable
>>>> > modules, which would avoid this mess of experimental algorithms inside the
>>>> > main-line kernel.  If done right, they might be able to work seamlessly
>>>> > with SCTP, too.  The tricky part is making sure the interface is complete
>>>> > enough.
There might be a noticeable performance impact to making it truly 
modular. Calling a function in a module is slower. In some tests, I see 
a 5 to 10% drop in performance when Ethernet driver is a module versus 
builtin.

You might want to look at how the I/O schedulers are configured as an 
example.

>>> 
>>> The symbols exported to allow this would need to be EXPORT_SYMBOL_GPL().
> 
> 
> Why's that?

Because the kernel developers who hold the collective copyright on the 
existing GPL TCP code do not want some vendor producing a closed source 
binary module of "enhanced TCP".
