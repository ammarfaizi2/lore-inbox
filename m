Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265024AbRFZQa5>; Tue, 26 Jun 2001 12:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265027AbRFZQai>; Tue, 26 Jun 2001 12:30:38 -0400
Received: from [217.6.75.12] ([217.6.75.12]:13748 "EHLO ftp.prs.de")
	by vger.kernel.org with ESMTP id <S265024AbRFZQaa>;
	Tue, 26 Jun 2001 12:30:30 -0400
Message-ID: <3B38BA08.E2E0629@internetwork-ag.de>
Date: Tue, 26 Jun 2001 18:36:24 +0200
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Reply-To: tip@prs.de
Organization: interNetwork AG
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: SMP freeze w/ 2.4.x and unregister_netdev[ice]() [was ppp lockup...]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've done some testing w/ our SMP machine and the PPPDs - the FREEZE (lock)
occurs due to the locking via rtnl_lock()/rtnl_unlock() for unregister_netdevice
in ppp_destoy_interface.
The problem occurs on 2.4.0.SuSE and all vanilla 2.4.x kernels (just tested
2.4.5) in SMP mode only!!!

(And yes, not locking the lists works BUT ... :-)

All help is very much appreciated!
Thanks in advance,

Immanuel

P.S. Please put me on CC: if you reply - makes my list sorting easier... :-)

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de





