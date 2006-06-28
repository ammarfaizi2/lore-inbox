Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWF1RsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWF1RsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWF1RsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:48:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20130 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751508AbWF1RsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:48:17 -0400
Subject: Re: tty_mutex and tty_old_pgrp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Paul Fulghum <paulkf@microgate.com>, lkml <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <9e4733910606281036k53956aaev3d323fbb7a2cb7a9@mail.gmail.com>
References: <9e4733910606261538i584e2203o9555d77094de6fe7@mail.gmail.com>
	 <44A1B79F.9020204@microgate.com>
	 <9e4733910606272029r32255d27we6e8b34a4c2e569@mail.gmail.com>
	 <1151490240.15166.5.camel@localhost.localdomain>
	 <9e4733910606281036k53956aaev3d323fbb7a2cb7a9@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jun 2006 19:04:25 +0100
Message-Id: <1151517865.15166.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-28 am 13:36 -0400, ysgrifennodd Jon Smirl:
> This selinux code is checking to see if the current process still has
> access rights to it's controlling tty, right? If it doesn't tty and
> tty_old_pgrp are nulled out. Does this need locking? 

Yes that looks like it needs to the tty lock covering it.

