Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316607AbSFGBKF>; Thu, 6 Jun 2002 21:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316603AbSFGBKE>; Thu, 6 Jun 2002 21:10:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65175 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316600AbSFGBKD>;
	Thu, 6 Jun 2002 21:10:03 -0400
Date: Thu, 06 Jun 2002 18:06:33 -0700 (PDT)
Message-Id: <20020606.180633.05602904.davem@redhat.com>
To: zaitcev@redhat.com
Cc: Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] 4KB stack + irq stack for x86
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206061737.g56Hbws24655@devserv.devel.redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Thu, 6 Jun 2002 13:37:58 -0400

   >[...]
   > Of course, the situation is particularly bad on s390, because every
   > function call needs at least 96 bytes on the stack (due to the register
   > save areas required by our ABI).
   
   How is this different from sparc64?
   
Sparc64 even eats 192 bytes per function call, minimum.  Sibling call
optimization in current GCC helps, but it is still an issue.
