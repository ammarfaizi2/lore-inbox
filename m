Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUGLW1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUGLW1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 18:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUGLW1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 18:27:17 -0400
Received: from mail1.WPI.EDU ([130.215.36.102]:17298 "EHLO mail1.WPI.EDU")
	by vger.kernel.org with ESMTP id S263795AbUGLW1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 18:27:14 -0400
Date: Mon, 12 Jul 2004 18:27:13 -0400
From: "Charles R. Anderson" <cra@WPI.EDU>
To: linux-kernel@vger.kernel.org
Subject: Re: v2.6 IGMPv3 implementation
Message-ID: <20040712222713.GK7822@angus.ind.WPI.EDU>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040712203056.GI7822@angus.ind.WPI.EDU> <20040712140409.3575b900.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712140409.3575b900.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 02:04:09PM -0700, David S. Miller wrote:
> include/linux/in.h
> Specifically IP_MSFILTER and friends.

I noticed these.  Do you have a pointer to documentation on this API?

Another thing I noticed.  Which is better, __u32 or struct in_addr and
int?  Both are used in include/linux/in.h for what appear to be the
same objects:

struct ip_mreq 
{
	struct in_addr imr_multiaddr;	/* IP multicast address of group */
	struct in_addr imr_interface;	/* local IP address of interface */
};

struct ip_mreqn
{
	struct in_addr	imr_multiaddr;		/* IP multicast address of group */
	struct in_addr	imr_address;		/* local IP address of interface */
	int		imr_ifindex;		/* Interface index */
};

struct ip_mreq_source {
	__u32		imr_multiaddr;
	__u32		imr_interface;
	__u32		imr_sourceaddr;
};

struct ip_msfilter {
	__u32		imsf_multiaddr;
	__u32		imsf_interface;
	__u32		imsf_fmode;
	__u32		imsf_numsrc;
	__u32		imsf_slist[1];
};

> BTW, unlike you claim, the IGMPv3 stack implementation has been in the
> kernel for a long time, much before 2.6.7  It is even in the current
> 2.4.x sources as well.

Thank you for clarifying.  I only wish the userspace was caught up.

