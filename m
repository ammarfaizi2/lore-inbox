Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUDCJ3o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 04:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUDCJ3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 04:29:43 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:46317 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261668AbUDCJ3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 04:29:41 -0500
Date: Sat, 3 Apr 2004 11:27:55 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Adam Nielsen <a.nielsen@optushome.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       degger@tarantel.rz.fh-muenchen.de
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Message-ID: <20040403112755.A19308@electric-eye.fr.zoreil.com>
References: <20040403150229.75ec6b98.a.nielsen@optushome.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040403150229.75ec6b98.a.nielsen@optushome.com.au>; from a.nielsen@optushome.com.au on Sat, Apr 03, 2004 at 03:02:29PM +1000
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Nielsen <a.nielsen@optushome.com.au> :
[...]
> in the Realtek 8169 gigabit ethernet driver.  Due to a logic error,
> there is a loop in an interrupt handler that often goes infinite, thus
> locking up the entire computer.  The attached patch fixes the problem.

- until there is an explanation on _why_ this condition happens, this is a
  band-aid for an unexplained condition, not a fix for a "logic error" (it
  may have interesting performance effects though);

- the included comments may be ok in the bk repository but they do not really
  add anything to the driver itself;

- please avoid the "else break" in just one line;

- last change to this file found its way through the bk thing on 02/26/2004
  but a set of changes for this driver is available 1) in -mm tree 2) in
  Jeff Garzik's -netdev patches 3) near my fridge. A patch addressing the
  same issue has been posted on l-k the 03/29/2004 as an answer to a remark
  made by Daniel Egger (feedback anyone ?). If you can wait until the whole
  thing is included, it will make my life easier;

- please Cc: netdev@oss.sgi.com for network related patches as well as
  jgarzik@pobox.com for network drivers related patches

--
Ueimor
