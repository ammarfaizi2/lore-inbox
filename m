Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWI0NRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWI0NRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 09:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWI0NRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 09:17:40 -0400
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:64737 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1751158AbWI0NRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 09:17:39 -0400
Date: Wed, 27 Sep 2006 08:17:37 -0500
From: Jay Cliburn <jacliburn@bellsouth.net>
To: jgarzik@pobox.com
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] atl1: New driver, Attansic L1 Gigabit Ethernet
Message-ID: <20060927131737.GA11922@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Attansic L1 Gigabit Ethernet device driver.

Background:
Earlier this year I purchased an Asus M2V mainboard that contains 
an onboard Attansic L1 Gigabit Ethernet NIC.  The mainboard was 
delivered with an accompanying CD containing driver source code for 
the NIC.  Upon inspection, it was clear this source code was derived 
by Attansic in large part from the Intel e1000 driver.  Following 
Stephen Hemminger's advice provided in netdev email, I contacted 
Attansic and requested clarification on some confusing licensing
language and for permission to submit this driver for addition 
to the kernel.  To my surprise, Attansic consented[1].

Disclaimer:
I am not a netdev developer, and because of that there is a great deal 
about the inner workings of the driver I'm submitting here that I 
don't understand.  I've tried to make the driver look structurally 
like others found in drivers/net, but some things I just left alone 
in the interest of not breaking things.

I have combined the Attansic NIC driver's multiple C source files and
header files into a single C file and a single header file, and have
attempted to apply kernel coding standards to the files.  It compiles
cleanly and functions properly in 2.6.18-git7 under very rudimentary
IPv4, IPv6, and ethtool testing.  The patches were generated against 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
pulled 20060926.

Please accept this driver for consideration for inclusion in the
kernel.  Hopefully it will simplify the computing experience of
other Linux users of mainboards that contain this device.

Best regards,
Jay Cliburn
jacliburn@bellsouth.net

[1] Permission message from Attansic:
================================================================
X-Account-Key: account2
X-UIDL: <200609040112.k841ChxD015007@cnshm01.attansic.com>
X-Mozilla-Status: 0001
X-Mozilla-Status2: 00000000
Return-Path: <xiong_huang@attansic.com>
Received: from ibm06aec.bellsouth.net ([59.120.59.148])
          by imf04aec.mail.bellsouth.net with ESMTP
          id <20060904011336.LXVI15417.imf04aec.mail.bellsouth.net@ibm06aec.bellsouth.net>
          for <jacliburn@bellsouth.net>; Sun, 3 Sep 2006 21:13:36 -0400
Received: from twhqmg01.attansic.com ([59.120.59.148])
          by ibm06aec.bellsouth.net with ESMTP
          id <20060904011336.NHAL13366.ibm06aec.bellsouth.net@twhqmg01.attansic.com>
          for <jacliburn@bellsouth.net>; Sun, 3 Sep 2006 21:13:36 -0400
Received: from cnshm01.attansic.com (cnshm01.attansic.com [192.168.39.11])
    by twhqmg01.attansic.com (Postfix) with ESMTP id 73D3B282BF1
    for <jacliburn@bellsouth.net>; Mon,  4 Sep 2006 09:13:00 +0800 (CST)
Received: from xhuang (xxsun.shanghai.attansic.com [192.168.37.13] (may be forged))
    (authenticated bits=0)
    by cnshm01.attansic.com (8.12.11.20060308/8.12.11) with ESMTP id k841ChxD015007
    for <jacliburn@bellsouth.net>; Mon, 4 Sep 2006 09:12:57 +0800
Message-Id: <200609040112.k841ChxD015007@cnshm01.attansic.com>
Reply-To: <xiong_huang@attansic.com>
From: "Huang Xiong" <xiong_huang@attansic.com>
To: "'Jay Cliburn'" <jacliburn@bellsouth.net>
Subject: =?gb2312?B?tPC4tDogW1NFQ09ORCBSRVFVRVNUXSBSZTogR1BMIGFuZCBhdGwxIGRyaXY=?=
    =?gb2312?B?ZXI=?=
Date: Mon, 4 Sep 2006 09:12:56 +0800
Organization: attansic
MIME-Version: 1.0
Content-Type: text/plain;
    charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <44F885FA.3070809@bellsouth.net>
Thread-Index: AcbN+qA1xcZCiSkTSe+Fb93lmuAM5ABxHdRA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-attansic.com-MailScanner-Information: Please contact the ISP for more information
X-attansic.com-MailScanner: Found to be clean
X-attansic.com-MailScanner-From: xiong_huang@attansic.com
X-Spam-Status: No

Thank you!
You can change MODULE_LICENSE() as you want.


BR
Xiong

> -----=D3=CA=BC=FE=D4=AD=BC=FE-----
> =B7=A2=BC=FE=C8=CB: Jay Cliburn [mailto:jacliburn@bellsouth.net]
> =B7=A2=CB=CD=CA=B1=BC=E4: 2006=C4=EA9=D4=C22=C8=D5 3:12
> =CA=D5=BC=FE=C8=CB: xiong_huang@attansic.com
> =B3=AD=CB=CD: Jay Cliburn
> =D6=F7=CC=E2: [SECOND REQUEST] Re: GPL and atl1 driver
>
> The driver referenced below was created in large part from an existing
> Intel GPL network device driver.  As such, it is therefore a derived
> work from a GPL source program.
>
> Please modify the copyright and MODULE_LICENSE declarations in the
> source code so we can incorporate the driver into the Linux source tree.
>
> Thank you very much for your attention in this matter.
>
> Best regards,
> Jay Cliburn
>
> Jay Cliburn wrote:
>> Hello Xiong,
>>
>> I'm interested in having the Attansic L1 Gigabit Ethernet driver added
>> to the Linux kernel.  However, the MODULE_LICENSE() declaration in
>> at_main.c does not specify "GPL", but instead specifies "ATTANSIC". Thus
>> even though the LICENSE file declares the driver to be GPL, the
>> MODULE_LICENSE declarations embedded in the source code do not.
>>
>> May I please request that Attansic release the driver under GPL so we
>> can add it to the kernel?
>> 
>> Thank you very much.
>> 
>> Respectfully,
>> Jay Cliburn

