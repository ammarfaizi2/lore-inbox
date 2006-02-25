Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWBYW2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWBYW2h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWBYW2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:28:36 -0500
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:33694 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932134AbWBYW2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:28:35 -0500
Message-ID: <4400DA0B.1060502@free.fr>
Date: Sat, 25 Feb 2006 23:28:27 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: John Stoffel <john@stoffel.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
References: <43FF88E6.6020603@linux.intel.com>	<20060225084139.GB22109@infradead.org>	<200602250549.47547.gene.heskett@verizon.net>	<Pine.LNX.4.61.0602251518200.31692@yvahk01.tjqt.qr>	<pan.2006.02.25.22.07.53.810642@free.fr> <17408.55266.948833.168988@smtp.charter.net>
In-Reply-To: <17408.55266.948833.168988@smtp.charter.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

John Stoffel wrote:
>>>>>>"Matthieu" == Matthieu CASTET <castet.matthieu@free.fr> writes:
> 
> 
> Matthieu> I will say, why not put the restriction of the firmware
> Matthieu> binary blob ?  It run on the device so it will be difficult
> Matthieu> for people to analyse it.
> 
> So what do I do when I take my US laptop and fly to country X, which
> has comletely different rules for these radios?  Do I have to re-flash
> my firmware to make it work properly?  
> 
And what happen with the userspace binary blob ?

How it will know in which country you are ?
Does it access to a secret GPS on your computer ?

So there are 2 solutions :
- make the card work only for a country with a flag in a RO eeprom or in 
another place in the hardware (firmware, ....).
- make the card works on all the possible channels.

Also if the firmware need to be load each time you reset the card (this 
is the case with the current ipw2xxx implementation), you won't notice 
if you switch for a firmware for a country X to a firmware for a country Y.

Matthieu
