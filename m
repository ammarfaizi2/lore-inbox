Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282124AbRKWLaL>; Fri, 23 Nov 2001 06:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282145AbRKWLaB>; Fri, 23 Nov 2001 06:30:01 -0500
Received: from mx3.port.ru ([194.67.57.13]:63247 "EHLO smtp3.port.ru")
	by vger.kernel.org with ESMTP id <S282124AbRKWL3u>;
	Fri, 23 Nov 2001 06:29:50 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200111231132.fANBWbk11468@vegae.deep.net>
Subject: Re: Heavy disk IO stalls ftp/http downloads
To: harisri@bigpond.com
Date: Fri, 23 Nov 2001 14:32:36 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        does hdparm -u1 fixes the problem?
       -u1 == unmasq irq during its handling
    the problem is that serial port need its interrupt to be served with minimal
   latency, and the drives makes that impossible, unless irqs are unmasked...

   looks like ( = - disc io irq handling periods, . - the ones of serial port):

    both ones wants something like:

   disc:   =========  =============  ================== ============= =========
   serial: .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .

  in reality:  ==============.=============. ============= ===========

   etc etc...


cheers, Samium Gromoff
