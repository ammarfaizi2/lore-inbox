Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSHOAMf>; Wed, 14 Aug 2002 20:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSHOAMf>; Wed, 14 Aug 2002 20:12:35 -0400
Received: from 209-221-203-149.dsl.qnet.com ([209.221.203.149]:2831 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S316088AbSHOAMf>; Wed, 14 Aug 2002 20:12:35 -0400
Subject: smp_num_cpus undeclared workaround
From: Scott Bronson <bronson@rinspin.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1029367539.20388.7.camel@emma>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.7 
Date: 14 Aug 2002 17:15:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.19:

I was being plagued by the smp_num_cpus undeclared problems that seems
be circulating since the 2.3 days.  I appear to have triggered it by
turning SMP on, doing a full build, and then turning it off.  No
combination of make clean/dep/etc fixes it.  Finally, in desperation, I
tried:

        cp .config ~/config.bak
        make mrproper
        cp ~/config.bak .config
        make

And that fixed it.  Surprising.  Has anyone looked into what file
isn't being properly cleaned?  Given the LKML traffic that this
problem has generated, this should probably be fixed.


Thanks,

    - Scott


