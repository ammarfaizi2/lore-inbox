Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277684AbRJIBh7>; Mon, 8 Oct 2001 21:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277688AbRJIBht>; Mon, 8 Oct 2001 21:37:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32136 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277684AbRJIBhg>;
	Mon, 8 Oct 2001 21:37:36 -0400
Date: Mon, 08 Oct 2001 18:37:18 -0700 (PDT)
Message-Id: <20011008.183718.01458450.davem@redhat.com>
To: pmanolov@Lnxw.COM
Cc: linux-kernel@vger.kernel.org
Subject: Re: discontig physical memory
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC2467B.C8093B19@lnxw.com>
In-Reply-To: <3BC23441.1EF944A2@lnxw.com>
	<20011008.162935.21930065.davem@redhat.com>
	<3BC2467B.C8093B19@lnxw.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Petko Manolov <pmanolov@Lnxw.COM>
   Date: Mon, 08 Oct 2001 17:36:11 -0700

   "David S. Miller" wrote:
   > Do something like this instead of whatever your bootmem
   > calls are doing now:
   > 
   >         bootmap_size = init_bootmem(0, (32 * 1024 * 1024));
   >         free_bootmem((4 * 1024 * 1024),
   >                      ((16 - 4) * 1024 * 1024));
   
   This is suppose to tell the kernel about the gap?
   
Precisely.  How else did you expect to let the kernel know?

Franks a lot,
David S. Miller
davem@redhat.com
