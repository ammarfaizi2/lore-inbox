Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTEaGGR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 02:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTEaGGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 02:06:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1973 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264147AbTEaGGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 02:06:17 -0400
Date: Fri, 30 May 2003 23:18:13 -0700 (PDT)
Message-Id: <20030530.231813.59666274.davem@redhat.com>
To: scrosby@cs.rice.edu
Cc: alexander.riesen@synopsys.COM, linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <oydd6i04gq8.fsf@bert.cs.rice.edu>
References: <20030530085901.GB11885@Synopsys.COM>
	<20030530.020040.52897577.davem@redhat.com>
	<oydd6i04gq8.fsf@bert.cs.rice.edu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Scott A Crosby <scrosby@cs.rice.edu>
   Date: 30 May 2003 10:05:51 -0500

   On Fri, 30 May 2003 02:00:40 -0700 (PDT), "David S. Miller" <davem@redhat.com> writes:
   
   > Indeed, I'd missed this.  GCC will emit the constant multiply
   > expansion unless the multiply cost is set VERY low.
   
   It may still be a win. This does a bit under a dozen instructions per
   byte. However, jenkin's does many bytes at a time.

It turns out to not be the case at all.  There is too much work
involved in the main loop just maintaining the 3-word + curbyte
state.

It needs to be optimized a bit.
