Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWHGSRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWHGSRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWHGSRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:17:48 -0400
Received: from terminus.zytor.com ([192.83.249.54]:56545 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932084AbWHGSRp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:17:45 -0400
Message-ID: <44D78337.40109@zytor.com>
Date: Mon, 07 Aug 2006 11:15:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Daniel Rodrick <daniel.rodrick@gmail.com>,
       Linux Newbie <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
References: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>  <44D7579D.1040303@zytor.com> <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com> <Pine.LNX.4.61.0608071958160.3365@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608071958160.3365@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> Agreed. But still having a single driver for all the NICs would be
>> simply GREAT for my setup, in which all the PCs will be booted using
>> PXE only. So apart from performance / relilability issues, what are
>> the technical roadblocks in this?
> 
> Netboot, in the current world, could be done like this:
> 
> 1. Grab the PXE ROM code chip manufacturers offer in case your network card 
> does not support booting via PXE yet and write it to an EPROM which most 
> PCI network cards have a socket for
> 
> 2. Use PXELINUX, boot that with the help of the PXE ROM code
> 
> 3. Put all drivers needed into the kernel or initrd; or send out different 
> initrds depending on the DHCP info the PXE client sent. 
> 

There is a program called "ethersel" included with PXELINUX which can be 
used to send out different initrds depending on an enumeration of PCI space.

	-hpa
