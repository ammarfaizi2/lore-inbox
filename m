Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314124AbSDVLes>; Mon, 22 Apr 2002 07:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314125AbSDVLer>; Mon, 22 Apr 2002 07:34:47 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:41924 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S314124AbSDVLer>;
	Mon, 22 Apr 2002 07:34:47 -0400
Date: Mon, 22 Apr 2002 13:34:14 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Adam Kaczynski <kaczor@dgt-lab.com.pl>
Cc: linux-kernel@vger.kernel.org, linuxppc-announce@lists.linuxppc.org
Subject: Re: HDLC driver for MPC860-based hardware
Message-ID: <20020422133414.A12262@fafner.intra.cogenit.fr>
In-Reply-To: <3CC3D0EC.1040908@dgt-lab.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

- please, please, please read Documentation/CodingStyle
- kmalloc can fail
- cache seems to be disabled (?) for pages you memcpy later -> why ?
- if register_hdlc_device() fails for some device, the succeeded one are
  deallocated but not unregistered
- alloc_mem() doesn't deallocate on failure
- goto may help handling failure

-- 
Ueimor
