Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUH0NHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUH0NHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 09:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbUH0NHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 09:07:04 -0400
Received: from web25210.mail.ukl.yahoo.com ([217.12.10.70]:21924 "HELO
	web25210.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264953AbUH0NGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 09:06:23 -0400
Message-ID: <20040827130622.62816.qmail@web25210.mail.ukl.yahoo.com>
Date: Fri, 27 Aug 2004 15:06:22 +0200 (CEST)
From: =?iso-8859-1?q?Yann=20Rapaport?= <yannusonline@yahoo.fr>
Subject: Link detection and netlink notification in Linux 2.4
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all kernel users!

I am currently working on implementing link state
detection with netlink notification on a Linux 2.4.24
kernel.

The first solution that comes to my mind is to add a
call to netdev_state_change() inside the
netif_carrier_on() and netif_carrier_off() functions.
But after reading the list archive ab out it, my
understanding is that it is not possible to call
netdev_state_change() at this level. This seems to be
related being or not inside interrupts.
Could anyone explain this to me?

The right solution seems to be a kernel thread that
looks up the device chain and tests the IFF_RUNNING
flag to decide or not to notify netlink. Couldn't this
set a performance problem?
Testing the ETHTOOL_GLINK flag also seems a good idea
to me. Which one is the most generic?

As I understand it, this feature was one of the aims
of the 2.5 kernel. Is it implemented in 2.6? Would you
advise me any piece of code to have a look at?

Thank you in advance.
--
Yann


	

	
		
Vous manquez d’espace pour stocker vos mails ? 
Yahoo! Mail vous offre GRATUITEMENT 100 Mo !
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Le nouveau Yahoo! Messenger est arrivé ! Découvrez toutes les nouveautés pour dialoguer instantanément avec vos amis. A télécharger gratuitement sur http://fr.messenger.yahoo.com
