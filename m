Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318743AbSICKCt>; Tue, 3 Sep 2002 06:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318739AbSICKCt>; Tue, 3 Sep 2002 06:02:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17875 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318733AbSICKCr>;
	Tue, 3 Sep 2002 06:02:47 -0400
Date: Tue, 03 Sep 2002 03:00:25 -0700 (PDT)
Message-Id: <20020903.030025.07037175.davem@redhat.com>
To: ak@suse.de
Cc: kuznet@ms2.inr.ac.ru, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       haveblue@us.ibm.com, Manand@us.ibm.com, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73y9ajqw85.fsf@oldwotan.suse.de>
References: <20020903.164243.21934772.taka@valinux.co.jp.suse.lists.linux.kernel>
	<20020903.005119.50342945.davem@redhat.com.suse.lists.linux.kernel>
	<p73y9ajqw85.fsf@oldwotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 03 Sep 2002 11:05:30 +0200

   x86-64 handles it (also in csum-copy). I think at least Alpha does it 
   too (that is where I stole the C csum-partial base from) But it's ugly.
   See the odd hack. 

Ok I think we really need to fix this then in the arches
where broken.  Let's do an audit. :-)

I question if x86 is broken at all.  It checks odd lengths
and x86 handles odd memory accesses transparently.  Please,
some x86 guru make some comments here :-)

It looks like sparc64 is the only platform where oddly aligned buffer
can truly cause problems and I can fix that easily enough.
