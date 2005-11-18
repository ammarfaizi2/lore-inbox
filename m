Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbVKRLlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbVKRLlh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 06:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbVKRLlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 06:41:36 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:29915 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1161074AbVKRLlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 06:41:36 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 18 Nov 2005 13:40:25 +0200
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <1132020468.27215.25.camel@mindpipe> <20051115185543.GI5735@stusta.de> <20051115222656.8D11816F4D9@smtp.lmc.cs.sunysb.edu>
In-Reply-To: <20051115222656.8D11816F4D9@smtp.lmc.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511181340.25529.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 00:27, Giridhar Pemmasani wrote:
> In essence, ndiswrapper is for those chipsets that have no open source
> drivers until one can be developed.
> 
> This issue raises a concern for me as developer of ndiswrapper. I
> perceive that some kernel developers have strong opinions against
> ndiswrapper. I see ndiswrapper as contributing my 2 cents - I have no
> vested interests in ndiswrapper, although it will be sad to see lot of
> effort and time put into ndiswrapper go waste.

Does it mean that you support ndiswrapper just because you wrote it?
I understand this, but it's not a valid technical reason why
it should be supported.

> However, I believe 
> there is a need for such a project: There is a company (Linuxant) that
> sells a product similar to ndiswrapper, ndisulator, which is similar
> to ndiswrapper, is merged into FreeBSD kernel, and ndiswrapper itself
> has been downloaded more than half a million times from Sourceforge
> alone. And not all native drivers support all the features that users
> need, e.g., WPA, whereas ndiswrapper supports all features provided by
> vendor for Windows driver. And there are chipsets for which open
> source drivers may not be available ever since they are rare. And if
> it takes many months/years to develop a stable open source driver,
> users need some way of using their hardware until then.

Companies got nice excuse for not giving us docs, making those
months/years even longer.

> And so on. I 
> am not trying to argue in favor of ndiswrapper at the cost of open
> source drivers, but that there is a genuine need for such a project,
> at least for now.

Ok, how can we make any progress on obtaining docs for TI acx wireless
chipset? Or on Prism54 "softmac" chipset? The reply is "Open source
driver already exists (ndiswrapper), go away".

BTW, a few of wireless developers are interested in writing _open source
firmware_ (not just driver) for these, and it is not that hard to do,
if only we had the docs on components which make up the device.
Both of those are based on ARM processor + some specialized chips.

How can we hope to persuade companies into releasing that info
when they are escaping from giving us even docs on "external" interface
to their firmware with ndiswrapper argument, let alone on "internal"
components?

> This is neither a complaint nor a plea; if option to chose 8k stacks
> is dropped in the kernel, so be it. If I find time to provide support
> for private 8k stacks within ndiswrapper, I will do that, so that if
> this patch makes into kernel, users who need some way of using the
> wireless cards can do so, for now.
> 
>   Adrian> Unconditionally enabling 4k stacks is the only way to
>   Adrian> achieve this.
> 
> I think this is a bit drastic. As I suggested earlier, making 4k
> stacks the default may be enough. For example, RedHat already
> distributes kernels with 4k stacks and I am not sure if you will get
> lot more cases, considering the popularity of RedHat.
--
vda
