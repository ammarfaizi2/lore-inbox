Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291762AbSBTLUY>; Wed, 20 Feb 2002 06:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291766AbSBTLUP>; Wed, 20 Feb 2002 06:20:15 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:29864 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291762AbSBTLUD>; Wed, 20 Feb 2002 06:20:03 -0500
Message-ID: <3C73865F.5060909@reviewboard.com>
Date: Wed, 20 Feb 2002 12:19:59 +0100
From: Chris Chabot <chabotc@reviewboard.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020219
X-Accept-Language: en,nl
MIME-Version: 1.0
To: nimeesh <nimeesh24@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: network booting
In-Reply-To: <20020220084310.95958.qmail@web12304.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, a NFS root is (as far as i know!) the only networked drive type 
linux can boot of.
(ofcource any variation of local storage can be used, but then PXE is 
not realy needed ;-)

For PXE documentation, check out /usr/share/doc/pxe-.... (atleast thats 
on a redhat box), and for NFS-ROOT documentation check out 
/usr/src/linux/Documentation/nfsroot.txt ;-)

What i found to work well for testing is to build a nfs-root kernel, 
which i booted from HD for testing, with the nfsroot/dhcp command's 
appended on the lilo line.. when that works, try to move it to PXE 
boot-strapping.

Also, be carefull with pxe / dhcpd.. the order in which you start up 
those servers will determine if it works or not (start dhcpd first, else 
pxe will try to take the dhcp port).

Last, get your self a good boot-strapper. The one provided by intel in 
the pxe package gave me more headaches then confort, so i switched to 
BPBatch.

For more info on config files etc, check out this piece JMZ wrote:
http://www.dnalounge.com/backstage/src/kiosk/

    -- Chris

nimeesh wrote:

>hello sir,
>
>I'm new to linux.I'm trying network booting of linux
>system.System Conf.(intel 815 chipset ,PXE
>bios,3com905c-ethernet card)
>
>In that i'm facing problem with kernel image and it's
>file system.
>
>It gives me error as
>kernel panic : unable to mount root fs on 01:00
>
>Is it necessary to use NFS or is it possible without
>that? Any special specification while creating kernel
>image and filesystem?
>If any body can tell me any doc available on net,i'll
>be very thankful.
>
>Thanks in Advance..
>nimeesh patel
>
>
>
>=====
>nimeesh patel
>Development Engg.
>DiviNet Access Tech Ltd.
>Pune.
>Ph.No. 91(20)5284696
>
>________________________________________________________________________
>Looking for a job?  Visit Yahoo! India Careers
>      Visit http://in.careers.yahoo.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



