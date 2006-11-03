Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752902AbWKCNRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbWKCNRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 08:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbWKCNRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 08:17:52 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:3136 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S1752807AbWKCNRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 08:17:51 -0500
Date: Fri, 3 Nov 2006 14:12:22 +0100 (MET)
Message-ID: <454B4042.7050307@acm.org>
From: U Kuehn <ukuehn@acm.org>
User-Agent: Mozilla/5.0 (compatible; MSIE 5.0)
MIME-Version: 1.0
To: linux-thinkpad@linux-thinkpad.org
CC: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Greg KH <greg@kroah.com>,
       Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
References: <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com> <20061101193134.GB29929@kroah.com> <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com> <20061101205330.GA2593@kroah.com> <20061101235540.GA11581@khazad-dum.debian.net> <20061102220145.GB2192@elf.ucw.cz>
In-Reply-To: <20061102220145.GB2192@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pavel Machek wrote:
> 
> echo '(700 mA * hour) / (14*day) \ A' | ucalc
> 
> ucalc> OK:  0.002083
> ucalc>
> 
>  ...that is about 2mA in low power standby mode (but still listening on
> GSM, getting calls, etc).
> 
>  ...so, mAh are probably good enough for capacity_*_charge, but would
> suck for current power consumption, as difference between 2mA and 3mA
> would be way too big. We need some finer unit in that case.
> 

That very much depends on the system. Having a laptop where the current
power consumption is around 10 Watts (or, at about 10 to 12 Volts,
nearly 1 A), having a resolution of 10 or even 100 mA would be OK.
However, on your cellphone with a standby consumption of 2mA, such a
resolution would be meaningless. What kind of resultion does the
hardware usually support?

And then there is the measurement error. Any ideas about what the actual
error ranges are?

Cheers
Ulrich
