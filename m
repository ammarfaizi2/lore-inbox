Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbSJNS41>; Mon, 14 Oct 2002 14:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262095AbSJNS41>; Mon, 14 Oct 2002 14:56:27 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:2047 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262094AbSJNS40>; Mon, 14 Oct 2002 14:56:26 -0400
Message-Id: <5.1.0.14.2.20021014115238.084140f8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Oct 2002 12:02:15 -0700
To: linux-kernel@vger.kernel.org
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: [RFC] Rename _bh to _softirq 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

Old BHs have been almost completely replaced with tasklets and softirqs.
Should we then rename _bh to _softirq ?
i.e
         local_bh_disable()      ->      local_softirq_disable()
         spin_lock_bh()          ->      spin_lock_softirq()
         bh_lock_sock()          ->      softirq_sock_lock()
         etc

Or maybe just 'si' if softirq is too long.

bh prefix and postfix seem to be confusing now.



Max

http://bluez.sf.net
http://vtun.sf.net

