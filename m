Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270852AbTG0Pht (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270853AbTG0Phs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:37:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30852
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270852AbTG0Phs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:37:48 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E19gnTj-00005f-00@calista.inka.de>
References: <E19gnTj-00005f-00@calista.inka.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059320952.13191.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 16:49:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-27 at 16:30, Bernd Eckenfels wrote:
> why is jffs2 so slow, if the cpu overhead can be totally neglected when
> writing to such slow media? I would asume a FS whic his optimized for not
> wearing out flash cards would reduce the IOs to the absolute minimum and
> therefore be fast be definition?

Flash cards are -slow-. Also jffs2 is mostly synchronous so it writes
the long bit by bit. The flash wear is on erase not write. You could
certainly teach jffs2 a bit more about batching writes. The other issue
with jffs2 is startup because it is a log you have to read the entire
log to know what state you are in


