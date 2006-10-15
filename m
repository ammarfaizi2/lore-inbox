Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752265AbWJNXyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbWJNXyi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 19:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbWJNXyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 19:54:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36257 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752265AbWJNXyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 19:54:37 -0400
Subject: Re: [PATCH 1/1] Char: correct pci_get_device changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       R.E.Wolff@BitWizard.nl, Amit Gud <gud@eth.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <1966866271061818079@wsc.cz>
References: <1966866271061818079@wsc.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Oct 2006 01:20:01 +0100
Message-Id: <1160871601.5732.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-15 am 01:36 +0200, ysgrifennodd Jiri Slaby:
> correct pci_get_device changes
> 
> Commits 881a8c120acf7ec09c90289e2996b7c70f51e996 and
> efe1ec27837d6639eae82e1f5876910ba6433c3f are totally wrong and

No I disagree, they are totally right. They stop crashes walking the
list during a hotplug of another card. If you hotplug the moxa or rio
card you are screwed. Your patches solve a different problem to the ones
the pci_dev_get changes solve.

Your changes also minimally handle the hotplug of the moxa or rio card
which I guess could theoretically happen in some weird system and are a
definite improvement.

> It affects moxa and rio char drivers. (All this stuff deserves to be
> converted to pci_probing, though.)

Agreed, or dropped

Acked-by: Alan Cox <alan@redhat.com>


