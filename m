Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319351AbSIFT1m>; Fri, 6 Sep 2002 15:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319352AbSIFT1m>; Fri, 6 Sep 2002 15:27:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44679 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319351AbSIFT1l>;
	Fri, 6 Sep 2002 15:27:41 -0400
Date: Fri, 06 Sep 2002 12:24:05 -0700 (PDT)
Message-Id: <20020906.122405.122283378.davem@redhat.com>
To: ak@suse.de
Cc: niv@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020906212619.A28172@wotan.suse.de>
References: <20020906202646.A2185@wotan.suse.de>
	<1031339954.3d78ffb257d22@imap.linux.ibm.com>
	<20020906212619.A28172@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 6 Sep 2002 21:26:19 +0200
   
   I'm not entirely sure it is worth it in this case. The locks are
   probably the majority of the cost.

You can more localize the lock accesses (since we use per-chain
locks) by applying a cpu salt to the port numbers you allocate.

See my other email.
