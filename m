Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTI2TQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264521AbTI2TQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:16:08 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:42205 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S264518AbTI2TQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:16:02 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6-mm1: too many defunct event threads
Date: Mon, 29 Sep 2003 21:15:57 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309292115.57918.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tested -mm1 in my laptop, with synaptics drivers, and saw lots of 
zombi event threads.

This does not occur in stock -test6.

gallir@minime:~$ ps ax| grep events
    3 ?        SW<    0:00 [events/0]
  389 ?        Z<     0:00 [events/0] <defunct>
  391 ?        Z<     0:00 [events/0] <defunct>
  393 ?        Z<     0:00 [events/0] <defunct>
  396 ?        Z<     0:00 [events/0] <defunct>
  398 ?        Z<     0:00 [events/0] <defunct>
  400 ?        Z<     0:00 [events/0] <defunct>
  402 ?        Z<     0:00 [events/0] <defunct>
  404 ?        Z<     0:00 [events/0] <defunct>
  406 ?        Z<     0:00 [events/0] <defunct>
  434 ?        Z<     0:00 [events/0] <defunct>
  436 ?        Z<     0:00 [events/0] <defunct>
  438 ?        Z<     0:00 [events/0] <defunct>
  440 ?        Z<     0:00 [events/0] <defunct>
  442 ?        Z<     0:00 [events/0] <defunct>
  444 ?        Z<     0:00 [events/0] <defunct>
  450 ?        Z<     0:00 [events/0] <defunct>
  452 ?        Z<     0:00 [events/0] <defunct>
  454 ?        Z<     0:00 [events/0] <defunct>
  456 ?        Z<     0:00 [events/0] <defunct>
  462 ?        Z<     0:00 [events/0] <defunct>
  464 ?        Z<     0:00 [events/0] <defunct>
  466 ?        Z<     0:00 [events/0] <defunct>
  469 ?        Z<     0:00 [events/0] <defunct>
  471 ?        Z<     0:00 [events/0] <defunct>
  473 ?        Z<     0:00 [events/0] <defunct>
  544 ?        Z<     0:00 [events/0] <defunct>
  707 ?        Z<     0:00 [events/0] <defunct>
  709 ?        Z<     0:00 [events/0] <defunct>
  711 ?        Z<     0:00 [events/0] <defunct>
  713 ?        Z<     0:00 [events/0] <defunct>
  738 ?        Z<     0:00 [events/0] <defunct>
  740 ?        Z<     0:00 [events/0] <defunct>
  742 ?        Z<     0:00 [events/0] <defunct>
  745 ?        Z<     0:00 [events/0] <defunct>
  776 ?        Z<     0:00 [events/0] <defunct>
  779 ?        Z<     0:00 [events/0] <defunct>
  783 ?        Z<     0:00 [events/0] <defunct>
  785 ?        Z<     0:00 [events/0] <defunct>


Regards,

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

