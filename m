Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293344AbSCSA0E>; Mon, 18 Mar 2002 19:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293348AbSCSAZz>; Mon, 18 Mar 2002 19:25:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:65469 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293344AbSCSAZh>;
	Mon, 18 Mar 2002 19:25:37 -0500
Date: Mon, 18 Mar 2002 16:22:17 -0800 (PST)
Message-Id: <20020318.162217.44270627.davem@redhat.com>
To: torvalds@transmeta.com
Cc: cort@fsmlabs.com, linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0203181446200.10517-100000@penguin.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Mon, 18 Mar 2002 14:47:19 -0800 (PST)

   On Mon, 18 Mar 2002, Cort Dougan wrote:
   > The cycle timer in this case is about 16.6MHz.
   
   Oh, you're cycle timer is too slow to be interesting, apparently ;(

We could modify the test program to use more portably timing functions
and doing the TLB accesses several times over.  While this would get
us something more reasonable on PPC, and be more portable, the results
would be a bit less accurate because we'd be dealing effectively with
averages instead of real cycle count samples.
