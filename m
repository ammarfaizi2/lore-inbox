Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSKDUi4>; Mon, 4 Nov 2002 15:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSKDUi4>; Mon, 4 Nov 2002 15:38:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47111 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262779AbSKDUiz>;
	Mon, 4 Nov 2002 15:38:55 -0500
Message-ID: <3DC6DC33.1010509@pobox.com>
Date: Mon, 04 Nov 2002 15:44:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: alan@lxorguk.ukuu.org.uk, greg@kroah.com, jung-ik.lee@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: 2.5.45 PCI Fixups for PCI HotPlug
References: <200211042029.MAA09749@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:

>	Jeff Garzik recently said that he doesn't want to incorporate
>hot plugging for arbitrary standard PCI cards until he hears about a
>hotplug configuration that uses that card (I'm cc'ing Jeff so he can
>correct me if I misunderstand). That would put the kernel at level 1
>in the above list.
>

No, I was talking more specifically about de2104x driver.

For general drivers I prefer __devinit out of general laziness:  if 
there is not an active and kernel-clueful maintainer, then it's better 
to mark everything __devinit [with the wastage it implies].  But for a 
few drivers with obviously provable/disprovable cases, __init may be better.

So it IMO matters WRT maintainer and testability issues as well as 
strictly kernel/technical issues.

    Jeff




