Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277702AbRJRNYh>; Thu, 18 Oct 2001 09:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277703AbRJRNY1>; Thu, 18 Oct 2001 09:24:27 -0400
Received: from rome.broadwing.net ([216.142.238.216]:16592 "EHLO
	rome.broadwing.net") by vger.kernel.org with ESMTP
	id <S277702AbRJRNYO>; Thu, 18 Oct 2001 09:24:14 -0400
Message-ID: <3BCECD77.F66D4248@ntr.net>
Date: Thu, 18 Oct 2001 08:39:19 -0400
From: "Marco C. Mason" <mason@ntr.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: p_gortmaker@yahoo.com
Subject: Re: Making diff(1) of linux kernels faster
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul--

Paul Gortmaker wrote:
> +          if (recursive && preread_dir)
> +           {
> +              preread(inf[0].name);
> +              preread(inf[1].name);
> +            }

While looking over your patch, I notice that you preload *both*
directories.  (At least, that's what the code above appears to do).
Have you tried just preloading one?  This may still give you the speed
benefit (as you'll most likely reduce the seeking) and put less pressure
on the memory system.

--marco


