Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVCIXFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVCIXFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVCIXCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:02:54 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:60555 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262144AbVCIW3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:29:11 -0500
Subject: Re: [PATCH] make st seekable again
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503092338300.6756@kai.makisara.local>
References: <200503081911.j28JBlxi016013@hera.kernel.org>
	 <1110401474.3116.241.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0503092338300.6756@kai.makisara.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110407237.28860.259.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 22:27:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 21:58, Kai Makisara wrote:
> While waiting for the application to be fixed, it was decided to restore 
> the old behaviour of the tape drivers.

Which means tar won't get fixed 8(

> I don't think implementing proper read-only lseek for tapes is worth the 
> trouble (reliable tracking of the current location is tricky). Purist 
> kernels can refuse lseeks. Pragmatic kernels can allow lseeks until 
> refusing those won't break common applications.

The problem is the existing behaviour code isn't just 'not useful' its
badly broken. No locking, no overflow checks, updates the wrong variable
etc. It is asking for nasty accidents with critical user data.

Alan
