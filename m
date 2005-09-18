Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVIRC57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVIRC57 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 22:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVIRC57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 22:57:59 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:47543 "HELO
	develer.com") by vger.kernel.org with SMTP id S1751281AbVIRC57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 22:57:59 -0400
Message-ID: <432CD7AF.1030109@develer.com>
Date: Sun, 18 Sep 2005 04:57:51 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jesper.juhl@gmail.com
CC: Matheus Izvekov <izvekov@lps.ele.puc-rio.br>,
       Development discussions related to Fedora Core 
	<fedora-devel-list@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: Assertion failed in libata-core.c:ata_qc_complete(3051)
References: <432BA524.40301@develer.com>	 <60030.200.141.101.221.1126969752.squirrel@correio.lps.ele.puc-rio.br>	 <432CB177.5070001@develer.com> <9a87484905091717524adfc854@mail.gmail.com>
In-Reply-To: <9a87484905091717524adfc854@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 9/18/05, Bernardo Innocenti <bernie@develer.com> wrote:

>>I've just opened the case to install some more RAM and
>>noticed that the SATA controller card wasn't completely
>>fitted into the PCI slot.  Could it be just a hardware
>>problem?  I don't know what that assartion is about.
>>
>>Nowadays, Fedora kernels don't differ much from stock
>>kernels plus the usual bugfixes.  I've now upgraded to
> 
> They still do differ though. When asked to retest with a stock kernel,
> indulging the person who asks is usually a good idea if you want your
> problem solved :)

I appreciate Matheus's help, but installing a stock
kernel on a production server and waiting a few days
to see if the bug shows up is problematic for me.


I've already reviewed Fedora-specific changes in this
kernel and none of them appears to be related to my
problem.  The only patch that comes close is:

  linux-2.6.11-libata-promise-pata-on-sata.patch


>>This is happening on our production server, and there are no
>>other computers next to it, so I can't easily hook in a
>>serial cable.
> 
> netconsole may be a useful alternative for you then.
> See Documentation/networking/netconsole.txt

Thanks for the suggestion.  I think I'll leave it enabled
on the server.  I've just compiled the netconsole module,
but it depends on the non-modular netpoll, so I'll have to
wait until next reboot in order to try it out.

By the way, the documentation doesn't say how to interface
with syslogd.  Is it sufficient to use port 514 and turning
on the -r option?

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

