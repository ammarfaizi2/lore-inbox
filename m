Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWHQNte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWHQNte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWHQN2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:28:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55951 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964885AbWHQN2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:28:06 -0400
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: 7eggert@gmx.de, Arjan van de Ven <arjan@infradead.org>,
       Dirk <noisyb@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060817132309.GX13639@csclub.uwaterloo.ca>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it>
	 <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz>
	 <1155821951.15195.85.camel@localhost.localdomain>
	 <20060817132309.GX13639@csclub.uwaterloo.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 14:48:50 +0100
Message-Id: <1155822530.15195.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 09:23 -0400, ysgrifennodd Lennart Sorensen:
> Why can't O_EXCL mean that the kernel prevents anyone else from issuing
> ioctl's to the device?  One would think that is the meaning of exlusive.

If you were designing a new OS from scratch you might want to explore
that semantic as a design idea. I wouldn't recommend it because a lot of
apps will be upset if they issue an ioctl and it mysteriously fails or
hangs.

Issues of this nature require high level synchronization and that
(witness email) is generally done in user space which is the only place
that has transaction level visibility.

Alan

