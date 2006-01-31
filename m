Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWAaWXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWAaWXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWAaWXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:23:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28625 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751682AbWAaWXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:23:11 -0500
Date: Tue, 31 Jan 2006 17:23:05 -0500
From: Dave Jones <davej@redhat.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compile error in latest git pull - post 2.6.16-rc1-git4
Message-ID: <20060131222305.GE29937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-kernel@vger.kernel.org
References: <43DFBA93.3090103@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DFBA93.3090103@lwfinger.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 01:29:23PM -0600, Larry Finger wrote:
 > After doing a git pull from linux/kernel/git/torvalds/linux-2.6.git, I get 
 > the following compiler error:
 > 
 >   CC      net/ipv4/igmp.o
 > net/ipv4/igmp.c: In function ‘igmp_rcv’:
 > net/ipv4/igmp.c:973: error: label at end of compound statement
 > 
 > Using git bisect, the patch that introduces this error is:
 > 
 >  c5d90e000437a463440c1fe039011a02583a9ee5 is first bad commit
 > diff-tree c5d90e000437a463440c1fe039011a02583a9ee5 (from 
 > e2c2fc2c8f3750e1f7ffbb3ac2b885a49416110c)
 > Author: Dave Jones <davej@redhat.com>
 > Date:   Mon Jan 30 20:27:17 2006 -0800
 > 
 >     [IPV4] igmp: remove pointless printk
 > 
 >     This is easily triggerable by sending bogus packets,
 >     allowing a malicious user to flood remote logs.
 > 
 >     Signed-off-by: Dave Jones <davej@redhat.com>
 >     Signed-off-by: David S. Miller <davem@davemloft.net>
 > 
 > 
 > I suspect this error arises due to differences between gcc 4.0.2 and 
 > earlier releases. The patch is as follows:

Looks good.

Signed-off-by: Dave Jones <davej@redhat.com>

		Dave
