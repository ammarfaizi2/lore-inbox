Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUFMKxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUFMKxT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 06:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265042AbUFMKxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 06:53:19 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:494 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S265041AbUFMKxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 06:53:10 -0400
X-Sasl-enc: 155kv7pABlvNC1ZsH3XBMA 1087123989
Message-ID: <40CC320F.2050500@mailcan.com>
Date: Sun, 13 Jun 2004 12:53:03 +0200
From: Leon Woestenberg <leonw@mailcan.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
Cc: Andre Tomt <andre@tomt.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Serial ATA (SATA) on Linux status report (2.6.x mainstream	plan
 for AHCI and iswraid??)
References: <20040610155740.81227.qmail@web90109.mail.scd.yahoo.com>	 <40C8A5F6.3030002@pobox.com>  <40C9193F.9080107@tomt.net> <1087051010.25334.4.camel@lotte.street-vision.com>
In-Reply-To: <1087051010.25334.4.camel@lotte.street-vision.com>
Content-Type: multipart/mixed;
 boundary="------------050008090209090605040409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050008090209090605040409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Justin Cormack wrote:
> On Fri, 2004-06-11 at 03:30, Andre Tomt wrote:
> 
>>Since we're on the topic of new libata drivers, how is the Marvell 
>>driver coming along? I'm getting several server units with a 4-port 
>>version on-board in the not-so-distant future, it would be nice if they 
>>could use all their drive bays ;-)
> 
We have those as well. (Supermicro P4SCT+ which have a rev 03 88sx8041
part.)

> 
> Though not as useful as a libata driver (and not GPL, though the license
> is entirely unrestrictive), there is an open source driver for the
> Marvell chipsets:
> 
> http://www.highpoint-tech.com/BIOS%20%2B%20Driver/rr1820a/Linux/rr182x-openbuild-v1.02.tgz
> 
> It wont build on 2.6 due to cli/sti (v. easy to fix though - its just
> the irq locking), and it only supports 8 channel chips (only a few
> #defines for PCI ids and number of ports). Intend to fix it up and test
> it next week if the libata driver not out, as I have a few of these. The
> highpoint card is the first PCI-X SATA card I have actually managed to
> get hold of, but unlike other highpoint cards is not their chipset:
> 
> 03:02.0 SCSI storage controller: Marvell MV88SX5081 8-port SATA I PCI-X
> Controller (rev 03)
> 
I have a totally different set of source code files for the 
MV88SX50[4|8][0|1] chips, also open-source from Marvell (although I have
to check the exact license).

Looking at the Highpoint source code, they seem to have taken some of 
the Marvell source code (mv*.*) and adapted it for their RAID system.

I am interested in doing some maintenance work on the Marvell driver,
which indeed mostly needs attention to proper locking. Also, it did
not yet support the rev 03 hardware when I downloaded it.

I found the driver source on ftp://ftp.supermicro.com, but it seems to
have been removed lately. Supermicro forwards me to Adaptec who writes
the BIOS raid system (ugh).

Regards,

Leon.

--------------050008090209090605040409
Content-Type: text/x-vcard; charset=utf8;
 name="leonw.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="leonw.vcf"

begin:vcard
fn:Leon Woestenberg
n:Woestenberg;Leon
version:2.1
end:vcard


--------------050008090209090605040409--
