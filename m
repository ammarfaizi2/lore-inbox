Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRBOAjM>; Wed, 14 Feb 2001 19:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130411AbRBOAjC>; Wed, 14 Feb 2001 19:39:02 -0500
Received: from jalon.able.es ([212.97.163.2]:24807 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129534AbRBOAiy>;
	Wed, 14 Feb 2001 19:38:54 -0500
Date: Thu, 15 Feb 2001 01:38:46 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: modules_install target
Message-ID: <20010215013846.A25812@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently noticed that 'make modules_install' tries as a last step

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.1-ac13; fi

I depends on 'make install' doing the right symlinks in /boot.
Would not be better to do a:

if [ -r System.map-2.4.1-ac13 ]; then /sbin/depmod -ae -F System.map-2.4.1-ac13 
 2.4.1-ac13; fi

???

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac10 #1 SMP Sun Feb 11 23:36:46 CET 2001 i686

