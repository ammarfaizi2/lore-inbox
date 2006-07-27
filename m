Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWG0SNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWG0SNY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWG0SNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:13:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9610 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750981AbWG0SNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:13:24 -0400
Subject: Re: Nasty git corruption problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607261041490.29649@g5.osdl.org>
References: <1153929715.13509.12.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607260945440.29649@g5.osdl.org>
	 <Pine.LNX.4.63.0607261935160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0607261039380.29649@g5.osdl.org>
	 <Pine.LNX.4.64.0607261041490.29649@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 19:32:07 +0100
Message-Id: <1154025127.13509.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-26 am 10:43 -0700, ysgrifennodd Linus Torvalds:
> (And if it wasn't already obvious, with my patch you still need to do 
> "git-fsck-objects --full --lost-n-found" if you want to look inside those 
> pack-files, but at least it's an option you can enable).

git-lost-found turns up some of the missing stuff that was applied
earliest in the rebase but the other stuff is apparently neither visible
anywhere in the tree or missing (the tree I was rebasing "^^^..." never
shows it nor does the log). The changes are in the objects if you dump
every object and investigate them by hand.

Beats me but a mix of a restore and reapplying some stuff from archived
email along with rescued objects seems to have recovered all lost
changesets.

Alan
