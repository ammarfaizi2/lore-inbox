Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbUKDBB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUKDBB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUKDA5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:57:22 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:63453 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262032AbUKDAvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:51:55 -0500
Date: Wed, 3 Nov 2004 16:51:45 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Roland Kaeser <roli8200@yahoo.de>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>,
       user-mode-linux-user@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [uml-user] Harddisk Shutdown while UML Guest Shutdown
Message-ID: <20041104005145.GB17583@taniwha.stupidest.org>
References: <200411032000.34677.blaisorblade_spam@yahoo.it> <20041103192155.86313.qmail@web26104.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103192155.86313.qmail@web26104.mail.ukl.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 08:21:55PM +0100, Roland Kaeser wrote:

> And no, the HOST!! freezes after exit of the guest kernel.

does this happen w/o the SKAS patch?

> And i get a Kernel panic from the HOST!! kernel, this in case the
> host (ide) harddisk drive spins down (but not spins up anymore).

oops details please

> My idea is that some routines to spin down the harddisk are been
> routed outside the uml guest kernel or not been sucessfully removed
> for the uml architecture.

unlikely, uml catches the ioctls hdparm uses (i have a patch for this
cleaning things up somewhere or maybe it got merged).  uml shouldn't
propagate the ioctls out

> Is it possible that the /sbin/halt binary can have made something
> with the hosts harddisk?

not directly, but it might trigger something

> How can i get the kernel panic message from the host?

uml is triggering a host OS bug
