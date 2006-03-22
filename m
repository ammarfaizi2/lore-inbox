Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWCVXtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWCVXtl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWCVXtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:49:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:22963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964840AbWCVXtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:49:40 -0500
X-Authenticated: #17142692
Message-ID: <4421E295.9090008@gmx.de>
Date: Thu, 23 Mar 2006 00:49:41 +0100
From: thomas schorpp <t.schorpp@gmx.de>
Reply-To: t.schorpp@gmx.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: de, en-us
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@infradead.org>
CC: Alan Stern <stern@rowland.harvard.edu>,
       "Ballentine, Casey" <crballentine@essvote.com>,
       video4linux-list@redhat.com, linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net, v4l-dvb-maintainer@linuxtv.org,
       mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [linux-usb-devel] RE: [usb-storage] Re: [v4l-dvb-maintainer]
 2.6.16-rc: saa7134 + u sb-storage = freeze
References: <Pine.LNX.4.44L0.0603161039410.5253-100000@iolanthe.rowland.org>	 <441F281E.5060405@gmx.de> <1142953149.4749.21.camel@praia>
In-Reply-To: <1142953149.4749.21.camel@praia>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab wrote:
> Alan,
> Em Seg, 2006-03-20 às 23:09 +0100, thomas schorpp escreveu:
> 
>>Alan Stern wrote:
>>
>>>On Wed, 15 Mar 2006, Ballentine, Casey wrote:
> 
> 
>>what DMA problem? ive always used via chipsets with usb. now the 8237. 
> 
> 
>>the via pci-busmaster dma hangs the system?
> 
> No. it is PCI to PCI transfers ocurring while you have DMA transfers.

i see

> 
> Video capture boards allow you to transfer information from his capture
> memory to video memory without CPU.

classic vga video overlay, e.g., right?

> The problem is that some chipsets
> (or BIOS) can't handle concurrency between such transfers and normal PCI
> busmaster transfers.

maybe the reason for the green flashes in the picture i have with epox 8kha+ 
and asrock k7vt4a+ (both via 82xx).
its gone since i added a sil680 pci ide-controller for the disks and using 
the via ide only for dvdr/dvdrw drives now..

> 
>> try setting pci latency to 64.
>>most bioses initialize with 32. this had been a known problem, for me too.
>>this has been left out of the discussion at via forums.
>>
>>and what knows a usb controller about MPEG? thats another layer.
>>
>>so a bios fixes this and other os have no problem with this, 
>>so its fixable by software. then do it now, pls.
> 
> If you have such a fix, great, but while we don't have it, it is better
> to blacklist pci2pci transfers (there are other supported methods that
> are a little slow, but works as well as), than to offer a risk of mass
> corruption at their disks.

yes, indeed a good point. remember i blamed the v4l bt87x driver with xawtv for 
corrupting my root fs on kernel 2.4 some years ago, you can find the bug report on 
the v4l list, if i remember it right... 

> 
> Btw, are you sure that other OS offers pci2pci transfers for those
> devices/chipsets?

the question is *if* the hardware can handle this, as you said, so 
blacklisting hardware that cannot handle this error free should be ok,
sorry.

but if windos hadnt had support for this, i wouldnt have been able 
to use overlay video with the hauppauge wintv bt87x for years without 
any issue i can remember... right?

> 
> 
>>and stop this "blacklisting habit", all these nowadays chips are designed-to-cost 
>>"consumer crap" somewhow.
>>or do you want linux-usb to be blacklisted as "broken" by the manufacturers blacklists? ;)
>>
>>
>>y
>>tom
>>
> 
> Cheers, 
> Mauro.
> 
> 

cheers,
tom
