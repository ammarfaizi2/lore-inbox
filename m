Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbTELSNX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbTELSNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:13:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27277 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262496AbTELSNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:13:19 -0400
Date: Mon, 12 May 2003 10:20:23 -0700 (PDT)
Message-Id: <20030512.102023.71099561.davem@redhat.com>
To: willy@debian.org
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru
Subject: Re: Message Signalled Interrupt support?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030512165331.GZ29534@parcelfarce.linux.theplanet.co.uk>
References: <20030512163249.GF27111@gtf.org>
	<20030512165331.GZ29534@parcelfarce.linux.theplanet.co.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Mon, 12 May 2003 17:53:31 +0100

   On Mon, May 12, 2003 at 12:32:49PM -0400, Jeff Garzik wrote:
   > Has anybody done any work, or put any thought, into MSI support?
   
   Work -- no.  Thought?  A little.  Seems to me that MSIs need to be
   treated as a third form of interrupts (level/edge/message).

The fact that Alpha already supports them pretty much transparently
suggests that the thing to do might very well be "nothing" :-)

To be honest, MSIs are very similar to how interrupts work on sparc64,
in that each device generates a unique interrupt cookie.  The only
different is the size of this cookie, MSIs are larger than sparc64's.
