Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRBQQiQ>; Sat, 17 Feb 2001 11:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129230AbRBQQiH>; Sat, 17 Feb 2001 11:38:07 -0500
Received: from jalon.able.es ([212.97.163.2]:43482 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129126AbRBQQh7>;
	Sat, 17 Feb 2001 11:37:59 -0500
Date: Sat, 17 Feb 2001 17:37:51 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro
Message-ID: <20010217173751.A1012@werewolf.able.es>
In-Reply-To: <3A8E3BA5.4B98E94E@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A8E3BA5.4B98E94E@yahoo.com>; from p_gortmaker@yahoo.com on Sat, Feb 17, 2001 at 09:51:49 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.17 Paul Gortmaker wrote:
> I was poking around in a vmlinux the other day and was surprised at the 
> amount of repetitive crap text that was in there.  For example, try:
> 
> strings vmlinux|grep $PWD|wc -c
> 
> which gets some 70KB in my case - depends on strlen($PWD) obviously.  The 
> culprit is BUG() in a static inline that is in a header file.  In this 
> case cpp expands __FILE__ to the full path of the header file in question. 
> (IIRC there is a __BASEFILE__ that would be a better choice than __FILE__)
> 

Or better __FUNCTION__. Or even better __func__ that is gcc and ANSI99 C
compatible.

Time to make a patch...

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac17 #1 SMP Sat Feb 17 01:47:56 CET 2001 i686

