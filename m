Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTE3Isj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTE3Isj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:48:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20142 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263493AbTE3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:48:37 -0400
Date: Fri, 30 May 2003 02:00:40 -0700 (PDT)
Message-Id: <20030530.020040.52897577.davem@redhat.com>
To: alexander.riesen@synopsys.COM
Cc: scrosby@cs.rice.edu, linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030530085901.GB11885@Synopsys.COM>
References: <oyd3cixc9ev.fsf@bert.cs.rice.edu>
	<20030529.232440.122068039.davem@redhat.com>
	<20030530085901.GB11885@Synopsys.COM>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alex Riesen <alexander.riesen@synopsys.COM>
   Date: Fri, 30 May 2003 10:59:01 +0200

       static
       int hash_3(int hi, int c)
       {
   	return (hi + (c << 4) + (c >> 4)) * 11;
       }
   
   gcc-3.2.1 -O2 -march=pentium
 ...   
   It is not guaranteed to be this way on all architectures, of course.
   But still - no multiplications.

Indeed, I'd missed this.  GCC will emit the constant multiply
expansion unless the multiply cost is set VERY low.
