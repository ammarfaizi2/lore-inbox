Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269535AbRHQDCZ>; Thu, 16 Aug 2001 23:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269517AbRHQDCP>; Thu, 16 Aug 2001 23:02:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8577 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269535AbRHQDCA>;
	Thu, 16 Aug 2001 23:02:00 -0400
Date: Thu, 16 Aug 2001 19:59:06 -0700 (PDT)
Message-Id: <20010816.195906.38712979.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B7C871E.1B37CA85@linux-m68k.org>
In-Reply-To: <3B7C8196.10D1C867@linux-m68k.org>
	<20010816.193841.98557608.davem@redhat.com>
	<3B7C871E.1B37CA85@linux-m68k.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Fri, 17 Aug 2001 04:53:18 +0200

   Most of the time that cast isn't needed and rather an indicator that
   something else is wrong, right now we don't even have a chance to detect
   such a situation.

Wrong.  This is legal:

int test(unsigned long a, int b)
{
	return min(a, b);
}

And the compiler will warn about it with your typeof version.
That is dumb and unacceptable.

Later,
David S. Miller
davem@redhat.com
