Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293103AbSB1AgD>; Wed, 27 Feb 2002 19:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293058AbSB1AgA>; Wed, 27 Feb 2002 19:36:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32137 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293103AbSB1AfI>;
	Wed, 27 Feb 2002 19:35:08 -0500
Date: Wed, 27 Feb 2002 16:32:46 -0800 (PST)
Message-Id: <20020227.163246.80134237.davem@redhat.com>
To: afranck@gmx.de
Cc: alan@lxorguk.ukuu.org.uk, florin@iucha.net, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre1-ac1
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <02022801273203.01097@dg1kfa>
In-Reply-To: <E16gEWj-0006aD-00@the-village.bc.nu>
	<02022801273203.01097@dg1kfa>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andreas Franck <afranck@gmx.de>
   Date: Thu, 28 Feb 2002 01:27:32 +0100

   +                       return i ? : -EFAULT;
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ <- This looks somewhat bogus, 
   shouldn't it be "return i ? i : -EFAULT;" instead?

They are equivalent, "x ? : foo" is a shorthand for
"x ? x : foo"
