Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTEBAIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbTEBAIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:08:21 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:30407 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262830AbTEBAIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:08:20 -0400
Date: Thu, 1 May 2003 20:16:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [BUG 2.5.67 (and probably earlier)] /proc/dev/net doesnt
  show all net device
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305012018_MC3-1-36FA-118B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:

> The reason that I say that is that I can reproduce this problem on
> 2.5.68, but only in an xterm or similar window, but when I switch back
> to a console, the entire device list is displayed.

 There are strange bugs in the console layer and/or the VGA text console.
Choosing 34-line text mode results in a 30-line screen that the system
thinks has 34, with four 'hidden' lines at the bottom (on PCI TNT adapter.)
Maybe a similar thing is happening in X?

 And BTW I found a way to get lots of network devices:

  1. Load the gre tunneling driver (GRE tunnels over IP)
  2. ip tunnel add gre1 mode gre remote 127.1.1.1 local 127.0.0.1 dev lo
  3. Repeat for as many as you like... I can't make the kernel
     send packets through them but they show up on the list.

------
 Chuck
