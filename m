Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTFFLx4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 07:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTFFLx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 07:53:56 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:8950 "EHLO gaston")
	by vger.kernel.org with ESMTP id S261249AbTFFLxz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 07:53:55 -0400
Subject: ide-disk and standby on shutdown
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1054901240.765.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jun 2003 14:07:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart, Alan !

Ì noticed the reboot/shutdown notifier that is in 2.4 to standby the
disk is gone from 2.5. Is that done via other means or just missing ?

I added to my latest version of the blk PM stuff a request type for
REQ_PM_SHUTDOWN in addition to REQ_PM_SUSPEND & REQ_PM_RESUME to match
more closely the semantics of struct device, which means i can very
easily implement that standby-on-shutdown with proper locking & queue
issues in IDE using the exact same meacnism as suspend.

What do you think ?

Ben.

