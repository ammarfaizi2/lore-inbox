Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbSLSSsc>; Thu, 19 Dec 2002 13:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSLSSsc>; Thu, 19 Dec 2002 13:48:32 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:15851 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265936AbSLSSsa>;
	Thu, 19 Dec 2002 13:48:30 -0500
Date: Thu, 19 Dec 2002 10:56:30 -0800
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@ines.ro>,
       James McKenzie <james@fishsoup.dhs.org>,
       Christian Gennerat <christian.gennerat@polytechnique.org>,
       Martin Lucina <mato@kotelna.sk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] : donauboe IrDA driver (resend)
Message-ID: <20021219185630.GC6703@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021219024632.GB1746@bougret.hpl.hp.com> <1040310314.1225.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040310314.1225.9.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 05:05:16PM +0200, Dumitru Ciobarcianu wrote:
> 
> Hello,
> 
> This module does not load all the time for me.
> If I do an "modprobe donauboe" it gives something like:
> 
[...]
> 
> If I try a few more times it will finally load...
> 
> The kernel is 2.4.20.0.pp.9 (RH rawhide kernel - 2.4.20-ac1 based) +
> acpi20021205 . I don't know why lspci shows "Toshiba Tecra 8100". The
> machine is an Toshiba Satellite Pro 4320.

	As I don't have this hardware, I fully depend on people trying
the code to know if it works or not. This driver has been for 6 months
in kernel 2.5.X and on my web page (and advertised on the IrDA mailing
list), and it's only today that I get the first negative bug report.
	I really wonder what I do wrong. Maybe I should throw untested
code straight in 2.4.X, like other people do, that may bring the bug
report faster.

	From my casual look at the driver code, it looks like the
hardware self test is failing. There is a way to disable this self
test via module parameter "do_probe". Maybe you want to check that.
	Also, would you mind sending this bug report to all three
maintainers of the driver ? Also : would you mind sending the log
output of the old toshoboe driver (assuming it works - does it ?).

	Have fun...

	Jean

P.S. : Full e-mail is at :
	http://marc.theaimsgroup.com/?l=linux-kernel&m=104031025012364&w=2
