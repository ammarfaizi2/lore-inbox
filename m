Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUGLUbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUGLUbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUGLUba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:31:30 -0400
Received: from mail1.WPI.EDU ([130.215.36.102]:51144 "EHLO mail1.WPI.EDU")
	by vger.kernel.org with ESMTP id S262756AbUGLUbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:31:02 -0400
Date: Mon, 12 Jul 2004 16:30:56 -0400
From: "Charles R. Anderson" <cra@WPI.EDU>
To: linux-kernel@vger.kernel.org
Subject: v2.6 IGMPv3 implementation
Message-ID: <20040712203056.GI7822@angus.ind.WPI.EDU>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please Cc any replies directly to my address, since I am not
subscribed.  Thanks.

I'm taking a look at the IGMPv3 implementation that was integrated
into the 2.6 kernel (2.6.7 specifically).  In the past there have been
patches floating around that implemented the IGMPv3 stack, and these
provided some new IOCTLs:

/* Multicast source filter calls */
#define SIOCSIPMSFILTER        0x89a0          /* set mcast src filter (ipv4) */
#define SIOCGIPMSFILTER 0x89a1         /* get mcast src filter (ipv4) */
#define SIOCSMSFILTER  0x89a2          /* set mcast src filter (proto indep) */
#define SIOCGMSFILTER  0x89a3          /* get mcast src filter (proto indep) */

These do not appear in the Linus kernel, though.  Does anyone know the
status of these ioctls and the IGMPv3 implementation in general?  I'm
trying to get the proper bits stuffed into glibc to make IGMPv3/SSM
usable, and I'm not sure what to do about these ioctls.  Should 4 new
ioctl numbers be reserved for these in case an implementation is
integrated, or should I just leave them out of glibc headers entirely?

Thanks.

