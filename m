Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268510AbTGISMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbTGISMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:12:24 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:14279 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S268510AbTGISMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:12:19 -0400
Message-ID: <3F0C5D55.4030304@rackable.com>
Date: Wed, 09 Jul 2003 11:22:13 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
CC: linux-kernel@vger.kernel.org, mru@users.sourceforge.net
Subject: Re: Promise SATA 150 TX2 plus
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <yw1xadbnx017.fsf@users.sourceforge.net> <02ff01c34642$5512d7f0$401a71c3@izidor>
In-Reply-To: <02ff01c34642$5512d7f0$401a71c3@izidor>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jul 2003 18:26:57.0760 (UTC) FILETIME=[AE4FE600:01C34647]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milan Roubal wrote:

>So other question - is there SATA controler that
>is working in linux multiple controlers (4 cards)
>and is for better bus than standart PCI? Like PCI-X or
>PCI 66 MHz like promise is?
>  
>

  Most current SATA cards aren't faster than 64/66.  Heck many are 
32/66, or 64/33.  The problem is most everyone other than 3ware's linux 
drivers suck.  I can't find a non raid SATA controller than works for me 
under linux.

  3ware cards tend to max out a 64/33 solt around 6 drives for 
sequential IO.  (This will change in their next gen cards)  You get much 
better performance with two 8 port cards running 6 drives each than a 
single 12 port card.  Personally I recommend either 3ware raid10, or 
linux software raid 5 if you're a performance junky.

  Adaptec does have a new 4 port card sata raid card.  It seems to work 
well, and the driver on their cdrom includes around 30 precompiled 
binaries for various RH, MDK, and Suse kernels.  Source for the updated 
aacraid driver is included.   An interesting side note their cdrom seem 
to run linux.  (Yes they seem to provide source/patches for the various 
gpl programs it uses.)

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


