Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267835AbUHERtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267835AbUHERtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267832AbUHERtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:49:36 -0400
Received: from the-village.bc.nu ([81.2.110.252]:10686 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267838AbUHERre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:47:34 -0400
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brett Russ <russb@emc.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <41126458.1050203@emc.com>
References: <41126458.1050203@emc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091724300.8043.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 17:45:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would make sure you are looking at the right register set in your own
code. Any code now thats going to exist for most 2.4 users will need to
do that itself, and after my 2.4 experience with the IDE core I'd advise
anyone working on it to

a) Pass it off to another maintainer as fast as possible ;)
b) Program defensively

Once Jeff has MWDMA and ATAPI in the new SATA/ATA driver he wrote then
migration might be an even better option. It'll certainly be easier to
do a lot of things right with the newest SATA code than with the current
IDE layer.


