Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286844AbRLVS1D>; Sat, 22 Dec 2001 13:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286835AbRLVS0x>; Sat, 22 Dec 2001 13:26:53 -0500
Received: from pop.gmx.net ([213.165.64.20]:39136 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S286844AbRLVS0p>;
	Sat, 22 Dec 2001 13:26:45 -0500
Date: Sat, 22 Dec 2001 19:26:21 +0100
From: Andreas Kinzler <akinzler@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: ast@domdv.de
Subject: RE: Injecting packets into the kernel
X-Mailer: Andreas Kinzler's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011222182648Z286844-18284+6190@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can use a raw socket:
> socket(AF_INET,SOCK_RAW,IPPROTO_RAW);

Just tried it. It really submits the packets. However, for the kernel they
are now LOCAL packets, which are not masq'ed. To make that work, they need
to look "remote" (means: received by a device). Any ideas?

> On 22-Dec-2001 Andreas Kinzler wrote:
>> I am trying to fix a problem in diald (demand dialing tool). The problem
>> is
>> that
>> somewhen you need to resubmit IP packets to the kernel that were buffered
>> while the
>> link (PPP in most cases) was down. However, a bit of debugging showed
>> that
>> the method
>> used in diald does not work. You cannot submit to ppp0 directly because
>> of
>> masq/forwaring
>> issues. Can somebody give me some hints how to submit packets from a user
>> mode programm.

