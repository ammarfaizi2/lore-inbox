Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTDRVGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 17:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263251AbTDRVGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 17:06:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29592 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263241AbTDRVGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 17:06:12 -0400
Date: Fri, 18 Apr 2003 14:10:14 -0700 (PDT)
Message-Id: <20030418.141014.17269641.davem@redhat.com>
To: latten@austin.ibm.com
Cc: kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: IPsecv6 integrity failures not dropped
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200304182017.h3IKH4ng019821@faith.austin.ibm.com>
References: <200304182017.h3IKH4ng019821@faith.austin.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: latten@austin.ibm.com
   Date: Fri, 18 Apr 2003 15:17:04 -0500

   I modified ah6_input() and esp6_input() to return zero instead of -EINVAL
   in the fix below. I tested it and it works.
   
   Please let me know if this is ok. 

I think it would be better if ipv6's upper-layer interface worked
like ipv4's.  ie. a < 0 return value means:

	next_proto =- ret;
	goto resubmit;

The less that is different between ipv4/ipv6 the better.
