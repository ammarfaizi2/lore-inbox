Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274497AbRITNr6>; Thu, 20 Sep 2001 09:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274496AbRITNrr>; Thu, 20 Sep 2001 09:47:47 -0400
Received: from [195.66.192.167] ([195.66.192.167]:32012 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S274495AbRITNrj>; Thu, 20 Sep 2001 09:47:39 -0400
Date: Thu, 20 Sep 2001 16:46:39 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <3531863216.20010920164639@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: NFS daemons in D state for 2 minutes at shutdown
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi NFS folks,

I am still fighting witn nfsd/lockd not dying upon killall5.
(they are stuck in D state for 2 mins and then die with
"rpciod: active tasks at shutdown?!" at console)

I found out that nfsd and lockd die as expected when I use
modified killall5 which do not SIGSTOP all tasks before
killing them.

Any idea why this makes such difference? Is this a bug in
nfsd/lockd or in killall5?
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


