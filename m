Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVARGgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVARGgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 01:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVARGgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 01:36:11 -0500
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:17900
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S261249AbVARGgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 01:36:06 -0500
Message-ID: <41ECAE55.8090605@bio.ifi.lmu.de>
Date: Tue, 18 Jan 2005 07:36:05 +0100
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
Cc: Andres Salomon <dilinger@voxel.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-as1
References: <1105605448.7316.13.camel@localhost>	 <41E7F44C.5010702@bio.ifi.lmu.de>  <41E8565A.4050707@gentoo.org> <1105737963.7677.6.camel@localhost> <41E882C8.9060208@gentoo.org>
In-Reply-To: <41E882C8.9060208@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andres, hi Daniel,

sorry for the delayed reply, but I was ill for a few days.

Daniel Drake wrote

> Hi Andres, Frank,
> 
> Andres Salomon wrote:
>>Odd.  I'll have to try Frank's .config and see if I can reproduce it (it
>>doesn't happen w/ mine).
> 
> Here is the patch that fixes it for me:
> 	http://linux.bkbits.net:8080/linux-2.6/cset@1.2273.1.9
> Needs to be applied alongside the rlimit and stack expansion fixes.

yes, this one fixes it for me, too. vgchange and "mount -o loop" work again!
I saw it was included in as2, too. I will test as2 during the next days.


> 
> Andres, I have not tried the patch you suggested, since I found that the above 
> one fixes it. However, judging by the description of the one you mailed me, I 
> don't think it will make any difference (I do not use highmem).

The highmem patch doesn't fix it here, but anyway, I've included it
in my patchset because we use CONFIG_4G on all out SMP hosts who have
a few GB of memory.

Thanks for your help!
cu,
Frank


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
